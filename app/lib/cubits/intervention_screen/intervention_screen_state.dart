part of 'intervention_screen_cubit.dart';

@immutable
sealed class InterventionScreenState {}

final class PushInterventionScreen extends InterventionScreenState {
  final TriggerApp triggerApp;

  PushInterventionScreen({required this.triggerApp});
}

final class PopInterventionScreen extends InterventionScreenState {}

final class IntenventionScreenClosed extends InterventionScreenState {}

final class InterventionScreenOpened extends InterventionScreenState {
  /// Milliseconds since epoch
  final int timestamp;
  final TriggerApp triggerApp;

  InterventionScreenOpened({required this.timestamp, required this.triggerApp});
}
