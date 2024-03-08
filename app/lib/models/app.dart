import 'package:hive/hive.dart';

part 'app.g.dart';

@HiveType(typeId: 0)
class App {
  @HiveField(0)
  final String name;

  @HiveField(1)

  // TODO: make is non-nullable
  final String? packageName; // For Android

  @HiveField(2)

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

@HiveType(typeId: 1)
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

@HiveType(typeId: 2)
class HealthyApp extends App {
  HealthyApp(
      {required String name,
      required String url,
      String? packageName,
      required this.requiredUsageDuration})
      : super(name: name, url: url, packageName: packageName);

  @HiveField(3)
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
      "requiredUsageDuration": requiredUsageDuration.inSeconds,
    };
  }
}
