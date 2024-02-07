package com.queezy

import android.app.usage.UsageStatsManager
import android.content.Intent
import android.provider.Settings
import android.app.usage.UsageEvents
import android.app.usage.UsageStats
import android.app.Activity
import android.content.pm.PackageManager
import android.content.pm.ApplicationInfo

class AppUsageApi(private val activity: Activity) {

    fun queryEvents(start: Long, end: Long): List<Map<String, Any?>>{
        val eventsList = ArrayList<Map<String, Any?>>()

        val usageStatsManager = activity.getSystemService(UsageStatsManager::class.java)
        val events = usageStatsManager.queryEvents(start, end)

        // Print all events
        while (events.hasNextEvent()) {
            val event = UsageEvents.Event()
            events.getNextEvent(event)

            var appLabel: Any? = null
            try {
                appLabel = getLabelByPackageName(event.getPackageName()) as Any?
            } catch (e: PackageManager.NameNotFoundException) {
                //e.printStackTrace()
            }

            val eventMap = HashMap<String, Any?>()
            eventMap.put("appStandbyBucket", event.getAppStandbyBucket())
            eventMap.put("className", event.getClassName())
            // Missing: event.getConfiguration()
            eventMap.put("eventType", event.getEventType())
            eventMap.put("packageName", event.getPackageName())
            eventMap.put("shortcutId", event.getShortcutId())
            eventMap.put("timestamp", event.getTimeStamp())
            eventMap.put("appLabel", appLabel)
            eventsList.add(eventMap)
        }

        return eventsList
    }

    fun checkUsageStatsPermission(): Boolean {
        val now = System.currentTimeMillis()
        val usageStatsManager = activity.getSystemService(UsageStatsManager::class.java)
        val stats = usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, 0, now)
        return stats.size > 0
    }

    fun requestUsageStatsPermission() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        activity.startActivity(intent)
    }

    fun queryAndAggregateUsageStats(start: Long, end: Long): Map<String, Map<String, Any?>> {
        val usageStatsManager = activity.getSystemService(UsageStatsManager::class.java)
        val stats = usageStatsManager.queryAndAggregateUsageStats(start, end)

        val statsMap = HashMap<String, Map<String, Any?>>()

        for (entry in stats.entries) {
            val key = entry.key

            val usageStats = entry.value

            var appLabel: Any? = null
            try {
                appLabel = getLabelByPackageName(usageStats.getPackageName()) as Any?
            } catch (e: PackageManager.NameNotFoundException) {
                //e.printStackTrace()
            }


            val usageStatsMap = HashMap<String, Any?>()
            usageStatsMap.put("firstTimeStamp", usageStats.getFirstTimeStamp())
            usageStatsMap.put("lastTimeForegroundServiceUsed", usageStats.getLastTimeForegroundServiceUsed())
            usageStatsMap.put("lastTimeStamp", usageStats.getLastTimeStamp())
            usageStatsMap.put("lastTimeUsed", usageStats.getLastTimeUsed())
            usageStatsMap.put("lastTimeVisible", usageStats.getLastTimeVisible())
            usageStatsMap.put("packageName", usageStats.getPackageName())
            usageStatsMap.put("totalTimeForegroundServiceUsed", usageStats.getTotalTimeForegroundServiceUsed())
            usageStatsMap.put("totalTimeInForeground", usageStats.getTotalTimeInForeground())
            usageStatsMap.put("totalTimeVisible", usageStats.getTotalTimeVisible())
            usageStatsMap.put("appLabel", appLabel)
            statsMap.put(key, usageStatsMap)
        }

        return statsMap
    }

    private fun getLabelByPackageName(packageName: String): String {
        val packageManager = activity.packageManager
        val applicationInfo = packageManager.getApplicationInfo(packageName, 0)
        return packageManager.getApplicationLabel(applicationInfo).toString()
    }
}