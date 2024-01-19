abstract class App {
  final String name;

  /// URL to open
  final String url;

  App({required this.name, required this.url});
}

class TriggerApp extends App {
  TriggerApp({required String name, required String url})
      : super(name: name, url: url);
}

class HealthyApp extends App {
  HealthyApp(
      {required String name,
      required String url,
      required this.requiredUsageDuration})
      : super(name: name, url: url);

  final Duration requiredUsageDuration;
}
