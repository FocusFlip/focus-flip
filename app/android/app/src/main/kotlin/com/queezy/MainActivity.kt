package com.FocusFlip

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import com.FocusFlip.AppUsageApi
import android.app.usage.UsageStatsManager


class MainActivity: FlutterActivity() {
    // Method channel
    private val CHANNEL = "com.example.quezzy/app_usage"
    private val appUsageApi = AppUsageApi(this)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler (this::methodCallHandler)
    }

    fun methodCallHandler(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "queryEvents") {
            val start = call.argument<Long?>("start") as Long
            val end = call.argument<Long?>("end") as Long

            val events = appUsageApi.queryEvents(start, end)

            result.success(events)
        } else if(call.method == "checkUsageStatsPermission"){
            val hasPermission = appUsageApi.checkUsageStatsPermission()
            result.success(hasPermission)
        } else if(call.method == "requestUsageStatsPermission"){
            appUsageApi.requestUsageStatsPermission()
            result.success(true)
        } else if(call.method == "queryAndAggregateUsageStats"){
            val start = call.argument<Long?>("start") as Long
            val end = call.argument<Long?>("end") as Long

            val usageStats = appUsageApi.queryAndAggregateUsageStats(start, end)
            result.success(usageStats)
        } 
        else {
            result.notImplemented()
        }
    }

    
}
