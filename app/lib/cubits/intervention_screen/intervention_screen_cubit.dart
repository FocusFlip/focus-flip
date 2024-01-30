import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:quezzy/cubits/shortcuts/heathy_app_intervention_state.dart';
import 'package:quezzy/repositories/main_repository.dart';
import 'package:timezone/timezone.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/app.dart';
import '../../utils/local_notifications.dart';
import '../shortcuts/shortcuts_cubit.dart';

part 'intervention_screen_state.dart';

class InterventionScreenCubit extends Cubit<InterventionScreenState> {
  static final InterventionScreenCubit instance = InterventionScreenCubit(
      shortcutsCubit: ShortcutsCubit.instance,
      mainRepository: MainRepository.instance);
  InterventionScreenCubit(
      {required this.shortcutsCubit, required this.mainRepository})
      : super(IntenventionScreenClosed());

  final ShortcutsCubit shortcutsCubit;
  final MainRepository mainRepository;

  /// In milliseconds
  static const double _waitingInterventionResponseTimeout = 10000;

  void openScreen(TriggerApp triggerApp) {
    print("[InterventionScreenCubit] Opening InterventionScreen");
    if (state is IntenventionScreenClosed) {
      print("[InterventionScreenCubit] Pushing InterventionScreen");
      emit(PushInterventionScreen(triggerApp: triggerApp));
    } else if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Refreshing InterventionScreen");
      emit(BeginIntervention(
          triggerApp: triggerApp,
          healthyApp: mainRepository.healthyApp,
          timestamp: DateTime.now().millisecondsSinceEpoch));
    }
  }

  void closeScreen() {
    print("[InterventionScreenCubit] Closing InterventionScreen");
    if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Popping InterventionScreen");
      emit(PopInterventionScreen());
    }
  }

  void markAsOpened(TriggerApp triggerApp) {
    print("[InterventionScreenCubit] InterventionScreen has been opened");
    emit(BeginIntervention(
        triggerApp: triggerApp,
        healthyApp: mainRepository.healthyApp,
        timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  void markAsClosed() {
    print("[InterventionScreenCubit] InterventionScreen has been closed");
    emit(IntenventionScreenClosed());
  }

  Future<void> launchTriggerApp(TriggerApp triggerApp) async {
    print("[InterventionScreenCubit] Launching trigger app");

    if (Platform.isIOS) {
      bool interventionDisabled =
          await shortcutsCubit.disableIntervention(triggerApp);
      print(
          "[InterventionScreenCubit] Intervention disabled: $interventionDisabled");
    }

    Uri uri = Uri.parse(triggerApp.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> launchHealthyAppAsIntervention(
      HealthyApp healthyApp, TriggerApp rewardingTriggerApp) async {
    if (!(state is BeginIntervention) && !(state is InterventionInterrupted)) {
      throw Exception(
          "InterventionScreenCubit.launchHealthyApp() can be called only when"
          " the intervention screen has been opened");
    }

    print("[InterventionScreenCubit] Launching healthy app");

    if (Platform.isIOS) {
      // TODO: can probably be refactored after the android implementation
      bool healthyAppMarkedAsLaunched =
          await shortcutsCubit.markHealthyAppInterventionAsStarted(
              healthyApp.requiredUsageDuration);
      print(
          "[InterventionScreenCubit] Healthy app marked as launched: $healthyAppMarkedAsLaunched");
    }

    _scheduleRewardNotification(
        rewardingTriggerApp, healthyApp.requiredUsageDuration);

    emit(InterventionInProgress(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: rewardingTriggerApp,
        healthyApp: healthyApp));

    await launchHealthyApp(healthyApp);
  }

  Future<void> launchHealthyApp(HealthyApp healthyApp) async {
    Uri uri = Uri.parse(healthyApp.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
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
        healthyApp: (state as InterventionInProgress).healthyApp);
    emit(newState);

    await Future.doWhile(_checkIntervantionResult);
  }

  Future<bool> _checkIntervantionResult() async {
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
      ));
    } else if (healthyAppInterventionState ==
        HealthyAppInterventionState.interrupted) {
      emit(InterventionInterrupted(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: (state as WaitingForInterventionResult).triggerApp,
        healthyApp: (state as WaitingForInterventionResult).healthyApp,
      ));
    } else if (healthyAppInterventionState ==
        HealthyAppInterventionState.inactive) {
      emit(InterventionResultTimeout(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        triggerApp: (state as WaitingForInterventionResult).triggerApp,
        healthyApp: (state as WaitingForInterventionResult).healthyApp,
      ));
    } else if (healthyAppInterventionState ==
        HealthyAppInterventionState.started) {
      await Future.delayed(const Duration(milliseconds: 250));
      return true;
    }

    return false;
  }
}
