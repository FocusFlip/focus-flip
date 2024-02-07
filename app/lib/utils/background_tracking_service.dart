import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late final FlutterBackgroundService backgroundTrackingService;

Future<void> initBackgroundAppTracking(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  assert(Platform.isAndroid);

  backgroundTrackingService = FlutterBackgroundService();

  const int notificationId = 888;
  const String notificationChannelId = 'background_app_tracking';
  const String notificationChannelName = 'Background App Tracking';
  const String notificationChannelDescription =
      'This channel is used for tracking apps the user wants to apply'
      ' an intervention on.';
  const AndroidNotificationChannel notificationChannel =
      AndroidNotificationChannel(
    notificationChannelId, // id
    notificationChannelName, // title
    notificationChannelDescription, // description
    importance: Importance.low, // importance must be at low or higher level
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(notificationChannel);

  final androidConfiguration = AndroidConfiguration(
      autoStart: true,
      isForegroundMode: true,
      onStart: _onStart,
      notificationChannelId: notificationChannelId,
      foregroundServiceNotificationId: notificationId,
      initialNotificationContent: "FocusFlip runs in the background to ensure"
          " you stay focused. Tap to open the app.",
      initialNotificationTitle: "FocusFlip is tracking your screen time.");
  final iosMockConfiguration = IosConfiguration(autoStart: false);

  await backgroundTrackingService.configure(
      iosConfiguration: iosMockConfiguration,
      androidConfiguration: androidConfiguration);
}

/// This is the entry point of the background service
/// It is called when the service is started and runs in a separate isolate
@pragma('vm:entry-point')
void _onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  // Bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    print("Running background service, time = + ${DateTime.now()}");
  });
}
