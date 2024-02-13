import 'dart:async';
import 'dart:io';

import 'package:flutter_background/flutter_background.dart';
import 'package:quezzy/models/event_type.dart';
import 'package:quezzy/repositories/app_usage_repository.dart';

import '../models/usage_event.dart';

/// This class performs the background app usage tracking. In comparison
/// to `initBackgroundAppTrackingService()`, this method does not start a
/// background service. Instead, it uses the main thread to run the background
/// tracking.
///
/// The disadvantage of this approach is that the battery consumption can be
/// higher than with a background service. However, the advantage is the easier
/// implementation.
class BackgroundAppUsageTracking {
  final Duration period;
  final AppUsageRepository appUsageRepository;

  // Stream of UsageEvents
  Stream<UsageEvent> get usageEvents => _usageEvents.stream;
  final _usageEvents = StreamController<UsageEvent>.broadcast();

  /// The key is the package name of the app
  final Map<String, UsageEvent> _lastUsageEvent = {};

  BackgroundAppUsageTracking(this.appUsageRepository,
      [this.period = const Duration(milliseconds: 500)]);

  Future<void> init() async {
    assert(Platform.isAndroid);

    if (!await appUsageRepository.checkUsageStatsPermission()) {
      print("[background_app_usage_tracking()] No permission for usage stats");
      return;
    }

    if (!await _bringToBackground()) {
      print("[background_app_usage_tracking()] Failed to bring to background");
      return;
    }

    print(
        "[background_app_usage_tracking()] Starting background app usage tracking.");

    Timer.periodic(period, (timer) async {
      if (!await FlutterBackground.isBackgroundExecutionEnabled) {
        print("Stopping background app usage tracking.");
        timer.cancel();
        return;
      }

      await _detectUsageEvent();
    });
  }

  Future<bool> _bringToBackground() async {
    final androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "FocusFlip is tracking your screen time",
      notificationText: "FocusFlip runs in the background to ensure"
          " you stay focused. Tap to open the app.",
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(
          name: 'background_icon',
          defType: 'drawable'), // Default is ic_launcher from folder mipmap
    );
    if (!await FlutterBackground.initialize(androidConfig: androidConfig)) {
      print(
          "[BackgroundAppUsageTracking] Failed to initialize background execution");
      return false;
    }

    if (!await FlutterBackground.enableBackgroundExecution()) {
      print(
          "[BackgroundAppUsageTracking] Failed to enable background execution");
      return false;
    }

    return true;
  }

  Future<void> _detectUsageEvent() async {
    var end = DateTime.now();
    var start = end.subtract(period);

    var events = await appUsageRepository.queryEvents(start, end);

    for (var event in events) {
      if (event.eventType == EventType.ACTIVITY_RESUMED ||
          event.eventType == EventType.ACTIVITY_PAUSED) {
        // Avoid duplicate events
        if (_lastUsageEvent.containsKey(event.packageName)) {
          var lastEvent = _lastUsageEvent[event.packageName]!;

          if (event.eventType == lastEvent.eventType) {
            continue;
          }
        }
        _lastUsageEvent[event.packageName] = event;

        _usageEvents.add(event);
      }
    }
  }
}
