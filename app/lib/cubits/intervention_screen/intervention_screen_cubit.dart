import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:overlay_pop_up/overlay_communicator.dart';
import 'package:overlay_pop_up/overlay_pop_up.dart';
import 'package:focus_flip/cubits/shortcuts/heathy_app_intervention_state.dart';
import 'package:focus_flip/models/event_type.dart';
import 'package:focus_flip/models/usage_event.dart';
import 'package:focus_flip/repositories/app_usage_repository.dart';
import 'package:focus_flip/repositories/main_repository.dart';
import 'package:timezone/timezone.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/app.dart';
import '../../screens/intervention_screen/intervention_overlay_window.dart';
import '../../utils/background_app_usage_tracking.dart';
import '../../utils/local_notifications.dart';
import '../shortcuts/shortcuts_cubit.dart';

part 'intervention_screen_state.dart';

class InterventionScreenCubit extends Cubit<InterventionScreenState> {
  static final InterventionScreenCubit instance = InterventionScreenCubit(
      shortcutsCubit: ShortcutsCubit.instance,
      mainRepository: MainRepository.instance,
      appUsageRepository: AppUsageRepository.instance);
  InterventionScreenCubit(
      {required this.shortcutsCubit,
      required this.mainRepository,
      required this.appUsageRepository})
      : super(IntenventionScreenClosed()) {
    if (Platform.isAndroid) {
      OverlayCommunicator.instance.onMessage?.listen((event) async {
        InterventionScreenState state = this.state;
        print("[InterventionScreenCubit] Received event from overlay: $event");
        if (event == InterventionOverlayWindow.REQUEST_INTERVENTION_DATA) {
          _provideInterventionData();
        } else if (event ==
            InterventionOverlayWindow.LAUNCH_HEALTHY_APP_INTERVENTION) {
          if (state is BeginIntervention) {
            await launchHealthyAppAsIntervention(
                state.healthyApp, state.requiredHealthyTime, state.triggerApp);
            await OverlayPopUp.closeOverlay();
          }
        } else if (event ==
            InterventionOverlayWindow.IGNORE_REWARD_AND_LAUNCH_HEALTHY_APP) {
          if (state is InterventionSuccessful) {
            await launchApp(state.healthyApp);
            markAsClosed();
            await OverlayPopUp.closeOverlay();
          }
        } else if (event == InterventionOverlayWindow.LAUNCH_TRIGGER_APP) {
          if (state is InterventionSuccessful) {
            await launchTriggerApp(state.triggerApp);
            // Do not call `markAsClosed()`, because the intervention screen is
            // marked as closed in `launchTriggerApp()`.
            await OverlayPopUp.closeOverlay();
          }
        } else {
          throw Exception("Unknown event from overlay: $event");
        }
      });
    }
  }

  final ShortcutsCubit shortcutsCubit;
  final MainRepository mainRepository;
  final AppUsageRepository appUsageRepository;

  /// In milliseconds
  static const double _waitingInterventionResponseTimeout = 10000;

  Future<void> startBackgroundAppUsageTracking() async {
    assert(Platform.isAndroid);

    bool enabled = await OverlayPopUp.checkPermission();
    if (!enabled) {
      print("Permission for overlay pop-up not granted");
      await OverlayPopUp.requestPermission();
      return;
    }

    AppUsageRepository appUsageRepository = AppUsageRepository.instance;
    if (!await appUsageRepository.checkUsageStatsPermission()) {
      print("Permission for usage stats not granted");
      appUsageRepository.requestUsageStatsPermission();
      return;
    }

    var backgroundAppTracking = BackgroundAppUsageTracking(appUsageRepository);
    await backgroundAppTracking.init();

    backgroundAppTracking.usageEvents.listen(_appUsageEventListener);
  }

  Future<void> _appUsageEventListener(UsageEvent event) async {
    Duration requiredHealthyTime =
        Duration(seconds: mainRepository.readRequiredHealthyTime());
    HealthyApp? healthyApp = mainRepository.healthyApp;
    if (healthyApp?.packageName == event.packageName) {
      print(
          "[MainScreenCubit] Detected usage event for healthy app: ${healthyApp!.name}");
      InterventionScreenState state = this.state;
      if (state is InterventionInProgress &&
          (event.eventType == EventType.ACTIVITY_PAUSED ||
              event.eventType == EventType.ACTIVITY_STOPPED)) {
        emit(InterventionInterrupted(
          timestamp: DateTime.now().millisecondsSinceEpoch,
          triggerApp: state.triggerApp,
          healthyApp: state.healthyApp,
          requiredHealthyTime: state.requiredHealthyTime,
        ));
      }
    } else {
      var triggerAppCandidates = mainRepository.triggerApps
          .where((element) => element.packageName == event.packageName);
      TriggerApp? triggerApp = triggerAppCandidates.firstOrNull;

      if (triggerApp != null && event.eventType == EventType.ACTIVITY_RESUMED) {
        print(
            "[MainScreenCubit] Detected usage event for trigger app: ${triggerApp.name}");

        bool interventionEnabled = true;

        InterventionScreenState state = this.state;
        if (state is TriggerAppOpenedAsReward) {
          if (state.triggerApp.packageName == triggerApp.packageName &&
              state.dateTime
                  .isAfter(DateTime.now().subtract(Duration(seconds: 10)))) {
            print(
                "[MainScreenCubit] Trigger app opened as reward: ${triggerApp.name}");
            interventionEnabled = false;
          }
        }

        if (interventionEnabled) {
          openScreen(triggerApp, healthyApp, requiredHealthyTime);
          await OverlayPopUp.showOverlay();

          assert(this.state is PushInterventionScreen ||
              this.state is BeginIntervention);

          // TODO: do not rely on the delay, as it can vary on different devices.
          /// Implement callback from the overlay window to the cubit.
          Future.delayed(const Duration(milliseconds: 1000), () async {
            _sendBeginInterventionState(this.state);
          });
        }
      }
    }
  }

  void _provideInterventionData() {
    InterventionScreenState state = this.state;
    if (state is BeginIntervention) {
      print("[InterventionScreenCubit] PushInterventionScreen: Providing"
          " intervention data");

      _sendBeginInterventionState(state);
    } else if (state is InterventionSuccessful) {
      print("[InterventionScreenCubit] InterventionSuccessful: Providing"
          " intervention data");

      _sendInterventionSuccessfulState(state);
      return;
    } else {
      print("[InterventionScreenCubit] Intervention data not available because"
          " the intervention screen is not opened (state: $state)");
    }
  }

  void _sendBeginInterventionState(InterventionScreenState state) {
    assert(state is BeginIntervention || state is PushInterventionScreen);

    markAsOpened();

    assert(this.state is BeginIntervention);

    TriggerApp triggerApp = (this.state as BeginIntervention).triggerApp;
    HealthyApp healthyApp = (this.state as BeginIntervention).healthyApp;
    Map<String, dynamic> data = {
      "state": InterventionOverlayWindow.BEGIN_INTERVENTION_STATE,
      "triggerApp": triggerApp.toJson(),
      "healthyApp": healthyApp.toJson(),
    };
    OverlayCommunicator.instance.send(data);
  }

  void _sendInterventionSuccessfulState(InterventionSuccessful state) {
    TriggerApp triggerApp = state.triggerApp;
    HealthyApp healthyApp = state.healthyApp;
    Map<String, dynamic> data = {
      "state": InterventionOverlayWindow.INTERVENTION_SUCCESSFUL_STATE,
      "triggerApp": triggerApp.toJson(),
      "healthyApp": healthyApp.toJson(),
    };
    OverlayCommunicator.instance.send(data);
  }

  void openScreen(TriggerApp triggerApp, HealthyApp? healthyApp,
      Duration requiredHealthyTime) {
    print("[InterventionScreenCubit] Opening InterventionScreen");
    if (state is IntenventionScreenClosed) {
      print("[InterventionScreenCubit] Pushing InterventionScreen");
      emit(PushInterventionScreen(
          triggerApp: triggerApp,
          healthyApp: healthyApp,
          requiredHealthyTime: requiredHealthyTime));
    } else if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Refreshing InterventionScreen");
      if (healthyApp != null) {
        emit(BeginIntervention(
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime,
            timestamp: DateTime.now().millisecondsSinceEpoch));
      } else {
        emit(InterventionHealthyAppMissing(
            timestamp: DateTime.now().millisecondsSinceEpoch,
            requiredHealthyTime: requiredHealthyTime,
            triggerApp: triggerApp));
      }
    }
  }

  void closeScreen() {
    print("[InterventionScreenCubit] Closing InterventionScreen");
    if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Popping InterventionScreen");
      emit(PopInterventionScreen());
    }
  }

  void markAsOpened() {
    print("[InterventionScreenCubit] InterventionScreen has been opened");
    InterventionScreenState state = this.state;
    if (state is PushInterventionScreen) {
      if (state.healthyApp != null) {
        emit(BeginIntervention(
            triggerApp: state.triggerApp,
            healthyApp: state.healthyApp!,
            timestamp: DateTime.now().millisecondsSinceEpoch,
            requiredHealthyTime: state.requiredHealthyTime));
      } else {
        emit(InterventionHealthyAppMissing(
            timestamp: DateTime.now().millisecondsSinceEpoch,
            triggerApp: state.triggerApp,
            requiredHealthyTime: state.requiredHealthyTime));
      }
    }
  }

  void markAsClosed() {
    print("[InterventionScreenCubit] InterventionScreen has been closed");
    emit(IntenventionScreenClosed());
  }

  Future<void> launchTriggerApp(TriggerApp triggerApp) async {
    print("[InterventionScreenCubit] Launching trigger app");
    assert(state is InterventionSuccessful);

    if (Platform.isIOS) {
      bool interventionDisabled =
          await shortcutsCubit.disableIntervention(triggerApp);
      print(
          "[InterventionScreenCubit] Intervention disabled: $interventionDisabled");
    }
    if (Platform.isAndroid) {
      emit(TriggerAppOpenedAsReward(
          triggerApp: triggerApp, dateTime: DateTime.now()));
    }

    await launchApp(triggerApp);
  }

  Future<void> launchHealthyAppAsIntervention(HealthyApp healthyApp,
      Duration requiredHealthyTime, TriggerApp rewardingTriggerApp) async {
    if (!(state is BeginIntervention) && !(state is InterventionInterrupted)) {
      throw Exception(
          "InterventionScreenCubit.launchHealthyApp() can be called only when"
          " the intervention screen has been opened");
    }

    print("[InterventionScreenCubit] Launching healthy app");

    if (Platform.isIOS) {
      // TODO: can probably be refactored after the android implementation
      bool healthyAppMarkedAsLaunched = await shortcutsCubit
          .markHealthyAppInterventionAsStarted(requiredHealthyTime);
      print(
          "[InterventionScreenCubit] Healthy app marked as launched: $healthyAppMarkedAsLaunched");
    }

    if (Platform.isIOS) {
      // TODO: fix notification on android
      //
      // Unfortunatelly, the scheduling of the notifications is not working
      // on Android yet. Therefore, the notification about the reward (permission
      // to use the trigger app) will be temporarily shown as full-screen overlay.
      _scheduleRewardNotification(rewardingTriggerApp, requiredHealthyTime);
    } else if (Platform.isAndroid) {
      // Schedule opening the trigger app
      Future.delayed(requiredHealthyTime, _checkInterventionResultAndroid);
    }

    emit(InterventionInProgress(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: rewardingTriggerApp,
        healthyApp: healthyApp,
        requiredHealthyTime: requiredHealthyTime));

    await launchApp(healthyApp);
  }

  Future<void> launchApp(App app) async {
    if (Platform.isAndroid) {
      await LaunchApp.openApp(
          androidPackageName: app.packageName!, iosUrlScheme: app.url);
    } else if (Platform.isIOS) {
      Uri uri = Uri.parse(app.url);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } else {
      throw Exception("Unknown platform");
    }
  }

  void _scheduleRewardNotification(TriggerApp triggerApp, Duration duration) {
    print("[InterventionScreenCubit] Scheduling reward notification");

    int id = int.parse(
        DateTime.now().millisecondsSinceEpoch.toString().substring(8));
    TZDateTime scheduledDate = TZDateTime.now(local).add(duration);

    NotificationDetails notificationDetails = const NotificationDetails();
    flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "Good start with productive time!",
        "Open this notification to open ${triggerApp.name}, or ignore it to"
            " do more productive things",
        scheduledDate,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: LocalNotificationPayloads.healtyAppTimerFinished);
  }

  Future<void> waitForInterventionResult() async {
    if (!(state is InterventionInProgress)) {
      throw Exception(
          "InterventionScreenCubit.waitForReward() can be called only when"
          " the intervention has been started or when already waiting for"
          " the intervention result");
    }

    WaitingForInterventionResult newState = WaitingForInterventionResult(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: (state as InterventionInProgress).triggerApp,
        healthyApp: (state as InterventionInProgress).healthyApp,
        requiredHealthyTime:
            (state as InterventionInProgress).requiredHealthyTime);
    emit(newState);

    await Future.doWhile(_checkIntervantionResultIOS);
  }

  Future<void> _checkInterventionResultAndroid() async {
    InterventionScreenState state = this.state;
    if (!(state is InterventionInProgress)) {
      // TODO: this should be handled in a better way. This method checks the
      /// conditions only once after the delay, but if the user closes and opens
      /// a trigger app twice, the user gets access to it earlier because the timer
      /// for the first opening is not stopped.
      ///
      print(
        "[InterventionScreenCubit] Intervention interrupted",
      );
      return;
    }
    InterventionSuccessful newState = InterventionSuccessful(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: state.triggerApp,
        healthyApp: state.healthyApp,
        requiredHealthyTime: state.requiredHealthyTime);
    emit(newState);
    await OverlayPopUp.showOverlay();

    // In case, the Flutter engine is already running and preserves the last
    // state of the app
    // TODO: do not rely on the delay, as it can vary on different devices.
    /// Implement callback from the overlay window to the cubit.
    Future.delayed(const Duration(milliseconds: 1000), () async {
      _sendInterventionSuccessfulState(newState);
    });
  }

  Future<bool> _checkIntervantionResultIOS() async {
    if (!(state is WaitingForInterventionResult)) {
      return false;
    }

    // Check for timeout
    bool timeoutExceeded = DateTime.now().millisecondsSinceEpoch -
            (state as WaitingForInterventionResult).timestamp >
        _waitingInterventionResponseTimeout;

    if (timeoutExceeded) {
      emit(InterventionResultTimeout(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: (state as WaitingForInterventionResult).triggerApp,
        healthyApp: (state as WaitingForInterventionResult).healthyApp,
        requiredHealthyTime:
            (state as WaitingForInterventionResult).requiredHealthyTime,
      ));
    }

    // Check HealthyAppInterventionState
    late HealthyAppInterventionState healthyAppInterventionState;
    if (Platform.isIOS) {
      healthyAppInterventionState =
          await shortcutsCubit.getHealthyAppInterventionState();
    } else if (Platform.isAndroid) {
      throw Exception("Not implemented yet");
    } else {
      throw Exception("Unknown platform");
    }
    print("[InterventionScreenCubit] Healthy app intervention state: "
        "$healthyAppInterventionState");

    if (healthyAppInterventionState == HealthyAppInterventionState.reward) {
      emit(InterventionSuccessful(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: (state as WaitingForInterventionResult).triggerApp,
        healthyApp: (state as WaitingForInterventionResult).healthyApp,
        requiredHealthyTime:
            (state as WaitingForInterventionResult).requiredHealthyTime,
      ));
    } else if (healthyAppInterventionState ==
        HealthyAppInterventionState.interrupted) {
      emit(InterventionInterrupted(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: (state as WaitingForInterventionResult).triggerApp,
        healthyApp: (state as WaitingForInterventionResult).healthyApp,
        requiredHealthyTime:
            (state as WaitingForInterventionResult).requiredHealthyTime,
      ));
    } else if (healthyAppInterventionState ==
        HealthyAppInterventionState.inactive) {
      emit(InterventionResultTimeout(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: (state as WaitingForInterventionResult).triggerApp,
        healthyApp: (state as WaitingForInterventionResult).healthyApp,
        requiredHealthyTime:
            (state as WaitingForInterventionResult).requiredHealthyTime,
      ));
    } else if (healthyAppInterventionState ==
        HealthyAppInterventionState.started) {
      await Future.delayed(const Duration(milliseconds: 250));
      return true;
    }

    return false;
  }
}
