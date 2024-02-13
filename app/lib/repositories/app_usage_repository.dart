import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quezzy/models/usage_event.dart';
import 'package:quezzy/models/usage_stats.dart';

class AppUsageRepository {
  AppUsageRepository._();
  static final AppUsageRepository instance = AppUsageRepository._();

  MethodChannel _methodChannel =
      const MethodChannel("com.example.quezzy/app_usage");

  Future<void> init() async {
    _methodChannel.setMethodCallHandler(_methodCallHandler);
  }

  Future<List<UsageEvent>> queryEvents(DateTime start, DateTime end) async {
    int startMillis = start.millisecondsSinceEpoch;
    int endMillis = end.millisecondsSinceEpoch;

    var result = await _methodChannel.invokeMethod("queryEvents", {
      "start": startMillis,
      "end": endMillis,
    }) as List<Object?>;

    List<UsageEvent> events = [];
    for (var event in result) {
      events.add(UsageEvent.fromMap(event as Map<Object?, Object?>));
    }

    return Future.value(events);
  }

  Future<Map<String, UsageStats>> queryAndAggregateUsageStats(
      DateTime start, DateTime end) async {
    int startMillis = start.millisecondsSinceEpoch;
    int endMillis = end.millisecondsSinceEpoch;

    Map<Object?, Object?> result =
        await _methodChannel.invokeMethod("queryAndAggregateUsageStats", {
      "start": startMillis,
      "end": endMillis,
    });

    Map<String, UsageStats> usageStats = {};
    result.forEach((key, value) {
      usageStats[key as String] =
          UsageStats.fromMap(value as Map<Object?, Object?>);
    });
    return Future.value(usageStats);
  }

  Future<bool> checkUsageStatsPermission() async {
    return await _methodChannel.invokeMethod("checkUsageStatsPermission");
  }

  Future<void> requestUsageStatsPermission() async {
    await _methodChannel.invokeMethod("requestUsageStatsPermission");
  }

  Future<dynamic> _methodCallHandler(MethodCall call) {
    print("[AppUsageRepository] Dart method invoked: ${call.method}");
    if (false) {
      //_appUsageChanged(call.arguments["appName"]);
    } else {
      throw UnimplementedError();
    }
    return Future.value();
  }
}
