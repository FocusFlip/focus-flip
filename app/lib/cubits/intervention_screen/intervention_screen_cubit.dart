import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
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

  void openScreen(TriggerApp triggerApp) {
    print("[InterventionScreenCubit] Opening InterventionScreen");
    if (state is IntenventionScreenClosed) {
      print("[InterventionScreenCubit] Pushing InterventionScreen");
      emit(PushInterventionScreen(triggerApp: triggerApp));
    } else if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Refreshing InterventionScreen");
      emit(InterventionScreenOpened(
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
    emit(InterventionScreenOpened(
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

    bool interventionDisabled =
        await shortcutsCubit.disableIntervention(triggerApp);
    print(
        "[InterventionScreenCubit] Intervention disabled: $interventionDisabled");

    Uri uri = Uri.parse(triggerApp.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> launchHealthyApp(
      HealthyApp healthyApp, TriggerApp rewardingTriggerApp) async {
    print("[InterventionScreenCubit] Launching healthy app");

    bool healthyAppMarkedAsLaunched = await shortcutsCubit
        .markHealthyAppInterventionAsStarted(healthyApp.requiredUsageDuration);
    print(
        "[InterventionScreenCubit] Healthy app marked as launched: $healthyAppMarkedAsLaunched");

    _scheduleRewardNotification(
        rewardingTriggerApp, healthyApp.requiredUsageDuration);

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
}
