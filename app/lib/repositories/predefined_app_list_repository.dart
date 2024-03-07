import 'package:focus_flip/models/app.dart';

/// We assume that the names are unique.
class PredefinedAppListRepository {
  static const List<TriggerApp> triggerApps = [
    TriggerApp(name: "Instagram", url: "instagram://"),
    TriggerApp(name: "Youtube", url: "youtube://"),
    // TODO: extend the list on iOS platform
    // TODO: check the urls and extend the list
  ];

  static const List<HealthyApp> healthyApps = [
    HealthyApp(
        name: "Anki",
        url: "anki://",
        requiredUsageDuration: Duration(seconds: 30)),
    // TODO: extend the list
  ];
}
