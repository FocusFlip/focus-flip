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

  const App({required this.name, required this.url, this.packageName});
}

@HiveType(typeId: 1)
class TriggerApp extends App {
  const TriggerApp(
      {required String name, required String url, String? packageName})
      : super(name: name, url: url, packageName: packageName);

  TriggerApp.fromJson(Map<String, dynamic> json)
      : super(
            name: json["name"],
            url: json["url"],
            packageName: json["packageName"]);
}

@HiveType(typeId: 2)
class HealthyApp extends App {
  const HealthyApp({
    required String name,
    required String url,
    String? packageName,
  }) : super(name: name, url: url, packageName: packageName);

  // TODO: remove requiredUsageDuration from this class
  HealthyApp.fromJson(Map<String, dynamic> json)
      : super(
          name: json["name"],
          url: json["url"],
          packageName: json["packageName"],
        );
}
