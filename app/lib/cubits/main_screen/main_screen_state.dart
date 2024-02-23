part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {
  final List<TriggerApp> triggerApps;
  final Duration? requiredHealthyTime;
  MainScreenState({required this.triggerApps})
      : requiredHealthyTime = Duration(seconds: 20);

  MainScreenState.withRequiredHealthyTime(
      {required this.triggerApps, this.requiredHealthyTime});
}

final class MainScreenInitial extends MainScreenState {
  MainScreenInitial({required super.triggerApps});
}

final class TriggerAppAdded extends MainScreenState {
  TriggerAppAdded({required super.triggerApps});
}

final class TriggerAppsCleared extends MainScreenState {
  TriggerAppsCleared({required super.triggerApps});
}

final class EmptyNameError extends MainScreenState {
  EmptyNameError({required super.triggerApps});
}

final class DuplicateNameError extends MainScreenState {
  DuplicateNameError({required super.triggerApps});
}

final class UpdatedRequiredHealthyTime extends MainScreenState {
  UpdatedRequiredHealthyTime(triggerApps, requiredHealthyTime)
      : super.withRequiredHealthyTime(
            triggerApps: triggerApps, requiredHealthyTime: requiredHealthyTime);
}
