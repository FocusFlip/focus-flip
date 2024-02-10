abstract class App {
  final String name;

  final String? packageName;

  /// For Android

  /// URL to open
  final String url;

  App({required this.name, required this.url, this.packageName});
}

class TriggerApp extends App {
  TriggerApp({required String name, required String url, String? packageName})
      : super(name: name, url: url, packageName: packageName);
}

class HealthyApp extends App {
  HealthyApp(
      {required String name,
      required String url,
      String? packageName,
      required this.requiredUsageDuration})
      : super(name: name, url: url, packageName: packageName);

  final Duration requiredUsageDuration;
}
