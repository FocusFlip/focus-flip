part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {
  final List<TriggerApp> triggerApps;

  MainScreenState({required this.triggerApps});
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
