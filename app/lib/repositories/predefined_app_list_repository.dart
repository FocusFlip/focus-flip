import 'package:focus_flip/models/app.dart';

/// We assume that the names are unique.
class PredefinedAppListRepository {
  static const List<TriggerApp> triggerApps = [
    TriggerApp(
        name: "Instagram",
        url: "instagram://",
        packageName: "com.instagram.android"),
    TriggerApp(
        name: "Youtube",
        url: "youtube://",
        packageName: "com.google.android.youtube"),
    // TODO: extend the list on iOS platform
    // TODO: check the urls/package names and extend the list
  ];

  static const List<HealthyApp> healthyApps = [
    HealthyApp(
        name: "Anki",
        url: "anki://",
        requiredUsageDuration: Duration(seconds: 30)),
    // TODO: extend the list
  ];
}
