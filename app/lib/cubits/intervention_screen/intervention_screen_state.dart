part of 'intervention_screen_cubit.dart';

@immutable
sealed class InterventionScreenState {}

final class PushInterventionScreen extends InterventionScreenState {
  final TriggerApp triggerApp;
  final HealthyApp? healthyApp;
  final Duration requiredHealthyTime;

  PushInterventionScreen(
      {required this.triggerApp,
      required this.healthyApp,
      required this.requiredHealthyTime});
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
  final Duration requiredHealthyTime;

  InterventionScreenOpened(
      {required this.timestamp,
      required this.triggerApp,
      required this.requiredHealthyTime});
}

final class InterventionHealthyAppMissing extends InterventionScreenOpened {
  InterventionHealthyAppMissing(
      {required int timestamp,
      required TriggerApp triggerApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            requiredHealthyTime: requiredHealthyTime);
}

abstract class InterventionScreenReadyAndOpened
    extends InterventionScreenOpened {
  final HealthyApp healthyApp;

  InterventionScreenReadyAndOpened(
      {required int timestamp,
      required TriggerApp triggerApp,
      required this.healthyApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            requiredHealthyTime: requiredHealthyTime);
}

final class BeginIntervention extends InterventionScreenReadyAndOpened {
  BeginIntervention(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime);
}

final class InterventionInProgress extends InterventionScreenReadyAndOpened {
  InterventionInProgress(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime);
}

final class WaitingForInterventionResult
    extends InterventionScreenReadyAndOpened {
  WaitingForInterventionResult(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime);
}

abstract final class EndIntervention extends InterventionScreenReadyAndOpened {
  EndIntervention({
    required int timestamp,
    required TriggerApp triggerApp,
    required HealthyApp healthyApp,
    required Duration requiredHealthyTime,
  }) : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime);
}

final class InterventionSuccessful extends EndIntervention {
  InterventionSuccessful(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime);
}

final class InterventionInterrupted extends EndIntervention {
  InterventionInterrupted(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime);
}

final class InterventionResultTimeout extends EndIntervention {
  InterventionResultTimeout(
      {required int timestamp,
      required TriggerApp triggerApp,
      required HealthyApp healthyApp,
      required Duration requiredHealthyTime})
      : super(
            timestamp: timestamp,
            triggerApp: triggerApp,
            healthyApp: healthyApp,
            requiredHealthyTime: requiredHealthyTime);
}
