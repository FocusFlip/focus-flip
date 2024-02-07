class UsageStats {
  final DateTime firstDateTime; // From firstTimeStamp
  final int lastTimeForegroundServiceUsed;
  final DateTime lastDateTime; // From lastTimeStamp
  final int lastTimeUsed;
  final int lastTimeVisible;
  final String packageName;
  final int totalTimeForegroundServiceUsed;
  final int totalTimeInForeground;
  final int totalTimeVisible;
  final String? appLabel;

  UsageStats(
      {required this.firstDateTime,
      required this.lastTimeForegroundServiceUsed,
      required this.lastDateTime,
      required this.lastTimeUsed,
      required this.lastTimeVisible,
      required this.packageName,
      required this.totalTimeForegroundServiceUsed,
      required this.totalTimeInForeground,
      required this.totalTimeVisible,
      required this.appLabel});

  factory UsageStats.fromMap(Map<Object?, Object?> json) {
    return UsageStats(
        firstDateTime:
            DateTime.fromMillisecondsSinceEpoch(json["firstTimeStamp"] as int),
        lastTimeForegroundServiceUsed:
            json["lastTimeForegroundServiceUsed"] as int,
        lastDateTime:
            DateTime.fromMillisecondsSinceEpoch(json["lastTimeStamp"] as int),
        lastTimeUsed: json["lastTimeUsed"] as int,
        lastTimeVisible: json["lastTimeVisible"] as int,
        packageName: json["packageName"] as String,
        totalTimeForegroundServiceUsed:
            json["totalTimeForegroundServiceUsed"] as int,
        totalTimeInForeground: json["totalTimeInForeground"] as int,
        totalTimeVisible: json["totalTimeVisible"] as int,
        appLabel: json["appLabel"] as String?);
  }
}
