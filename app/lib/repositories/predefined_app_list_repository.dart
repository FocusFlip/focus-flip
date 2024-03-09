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
    TriggerApp(name: "Facebook", url: "fb://"),
    TriggerApp(name: "X", url: "twitter://"),
    TriggerApp(name: "Snapchat", url: "snapchat://"),
    TriggerApp(name: "LinkedIn", url: "linkedin://"),
  ];

  static const List<HealthyApp> healthyApps = [
    HealthyApp(name: "Anki", url: "anki://"),
    HealthyApp(name: "Duolingo", url: "duolingo://"),
  ];
}
