import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focus_flip/cubits/intervention_screen/intervention_screen_cubit.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class LocalNotificationPayloads {
  static const String healtyAppTimerFinished = "healtyAppTimerFinished";
}

void initFlutterLocalNotificationsPlugin() {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  InitializationSettings initializationSettings = InitializationSettings(
    iOS: IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    ),
    android: AndroidInitializationSettings('mipmap/ic_launcher'),
  );
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: onSelectNotification,
  );

  // TODO: test scenario when the notification permission is not granted
}

@pragma('vm:entry-point')
Future<dynamic> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
  print("[main] onDidReceiveLocalNotification");

  return Future.value();
}

@pragma('vm:entry-point')
Future<dynamic> onSelectNotification(String? payload) {
  print("[main] onSelectNotification: $payload");

  if (payload == "healtyAppTimerFinished") {
    InterventionScreenCubit.instance.waitForInterventionResult();
  }

  return Future.value();
}
