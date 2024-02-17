import 'package:focus_flip/models/event_type.dart';

class UsageEvent {
  final int appStandbyBucket;
  final String? className;
  final EventType eventType;
  final String packageName;
  final String? shortcutId;
  final DateTime dateTime;
  final String? appLabel;

  UsageEvent(
      {required this.appStandbyBucket,
      required this.className,
      required this.eventType,
      required this.packageName,
      required this.shortcutId,
      required this.dateTime,
      required this.appLabel});

  factory UsageEvent.fromMap(Map<Object?, Object?> json) {
    return UsageEvent(
        appStandbyBucket: json["appStandbyBucket"] as int,
        className: json["className"] as String?,
        eventType: EventType(json["eventType"] as int),
        packageName: json["packageName"] as String,
        shortcutId: json["shortcutId"] as String?,
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["timestamp"] as int),
        appLabel: json["appLabel"] as String?);
  }
}
