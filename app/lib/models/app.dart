abstract class App {
  final String name;

  // TODO: make is non-nullable
  final String? packageName; // For Android

  /// URL to open
  final String url;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "packageName": packageName,
      "url": url,
    };
  }

  App({required this.name, required this.url, this.packageName});
}

class TriggerApp extends App {
  TriggerApp({required String name, required String url, String? packageName})
      : super(name: name, url: url, packageName: packageName);

  TriggerApp.fromJson(Map<String, dynamic> json)
      : super(
            name: json["name"],
            url: json["url"],
            packageName: json["packageName"]);

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "packageName": packageName,
      "url": url,
    };
  }
}

class HealthyApp extends App {
  HealthyApp(
      {required String name,
      required String url,
      String? packageName,
      required this.requiredUsageDuration})
      : super(name: name, url: url, packageName: packageName);

  final Duration requiredUsageDuration;

  HealthyApp.fromJson(Map<String, dynamic> json)
      : requiredUsageDuration =
            Duration(milliseconds: json["requiredUsageDuration"]),
        super(
          name: json["name"],
          url: json["url"],
          packageName: json["packageName"],
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "packageName": packageName,
      "url": url,
      "requiredUsageDuration": requiredUsageDuration.inMilliseconds,
    };
  }
}
