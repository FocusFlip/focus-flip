part of 'intervention_screen_cubit.dart';

@immutable
sealed class InterventionScreenState {}

final class PushInterventionScreen extends InterventionScreenState {}

final class PopInterventionScreen extends InterventionScreenState {}

final class IntenventionScreenClosed extends InterventionScreenState {}

final class InterventionScreenOpened extends InterventionScreenState {
  /// Milliseconds since epoch
  final int timestamp;

  InterventionScreenOpened({required this.timestamp});
}
