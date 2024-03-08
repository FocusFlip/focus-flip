part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {
  final List<TriggerApp> triggerApps;
  final HealthyApp? healthyApp;

  final Duration requiredHealthyTime;
  MainScreenState({required this.triggerApps, required this.healthyApp})
      : requiredHealthyTime = Duration(seconds: 20);

  MainScreenState.withRequiredHealthyTime(
      {required this.triggerApps,
      required this.requiredHealthyTime,
      required this.healthyApp});

  // MainScreenState.withHealthyApps({required this.triggerApps});
}

final class MainScreenInitial extends MainScreenState {
  MainScreenInitial(List<TriggerApp> triggerApps, Duration requiredHealthyTime,
      HealthyApp? healthyApp)
      : super.withRequiredHealthyTime(
            triggerApps: triggerApps,
            requiredHealthyTime: requiredHealthyTime,
            healthyApp: healthyApp);
}

final class TriggerAppAdded extends MainScreenState {
  TriggerAppAdded({required super.triggerApps, required super.healthyApp});
}

// final class HealthyAppAdded extends MainScreenState {
//   HealthyAppAdded({required super.healthyApps});
// }

final class TriggerAppsCleared extends MainScreenState {
  TriggerAppsCleared({required super.triggerApps, required super.healthyApp});
}

final class TriggerAppRemoved extends MainScreenState {
  TriggerAppRemoved(
      {required this.removedApp,
      required super.triggerApps,
      required super.healthyApp});

  final TriggerApp removedApp;
}

final class HealthyAppAdded extends MainScreenState {
  HealthyAppAdded({required super.triggerApps, required super.healthyApp});
}

final class HealthyAppRemoved extends MainScreenState {
  HealthyAppRemoved({required super.triggerApps, required super.healthyApp});
}

/// This state is emitted when the user tries to add a trigger app
/// that has already been added
final class DuplicateTriggerAppError extends MainScreenState {
  DuplicateTriggerAppError(
      {required super.triggerApps, required super.healthyApp});
}

final class UpdatedRequiredHealthyTime extends MainScreenState {
  UpdatedRequiredHealthyTime(List<TriggerApp> triggerApps,
      Duration requiredHealthyTime, HealthyApp? healthyApp)
      : super.withRequiredHealthyTime(
            triggerApps: triggerApps,
            requiredHealthyTime: requiredHealthyTime,
            healthyApp: healthyApp);
}

final class RequiredHealthyTimeError extends MainScreenState {
  RequiredHealthyTimeError(List<TriggerApp> triggerApps,
      Duration requiredHealthyTime, HealthyApp? healthyApp)
      : super.withRequiredHealthyTime(
            triggerApps: triggerApps,
            requiredHealthyTime: requiredHealthyTime,
            healthyApp: healthyApp);
}
