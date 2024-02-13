part of 'intervention_screen_cubit.dart';

@immutable
sealed class InterventionScreenState {}

final class PushInterventionScreen extends InterventionScreenState {
  final TriggerApp triggerApp;

  PushInterventionScreen({required this.triggerApp});
}

final class PopInterventionScreen extends InterventionScreenState {}

final class IntenventionScreenClosed extends InterventionScreenState {}

final class TriggerAppOpenedAsReward extends IntenventionScreenClosed {
  final TriggerApp triggerApp;
  final DateTime dateTime;

  TriggerAppOpenedAsReward({required this.triggerApp, required this.dateTime});
}

abstract class InterventionScreenOpened extends InterventionScreenState {
  /// Milliseconds since epoch
  final int timestamp;
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;

  InterventionScreenOpened(
      {required this.timestamp,
      required this.triggerApp,
      required this.healthyApp});
}

final class BeginIntervention extends InterventionScreenOpened {
  BeginIntervention(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp);
}

final class InterventionInProgress extends InterventionScreenOpened {
  InterventionInProgress(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp);
}

final class WaitingForInterventionResult extends InterventionScreenOpened {
  WaitingForInterventionResult(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp);
}

abstract final class EndIntervention extends InterventionScreenOpened {
  EndIntervention({
    required int timestamp,
    required TriggerApp triggerApp,
    required HealthyApp healthyApp,
  }) : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp);
}

final class InterventionSuccessful extends EndIntervention {
  InterventionSuccessful(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp);
}

final class InterventionInterrupted extends EndIntervention {
  InterventionInterrupted(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp);
}

final class InterventionResultTimeout extends EndIntervention {
  InterventionResultTimeout(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp);
}
