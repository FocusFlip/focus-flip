import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flip/cubits/intervention_screen/intervention_screen_cubit.dart';
import 'package:focus_flip/cubits/main_screen/main_screen_cubit.dart';
import 'package:focus_flip/screens/healthy_app_screen/healty_app_screen.dart';
import 'package:focus_flip/screens/intervention_screen/states/healthy_app_missing_intervention_screen.dart';
import 'package:focus_flip/screens/intervention_screen/states/trigger_app_not_selected_intervention_screen.dart';
import 'package:focus_flip/screens/trigger_app_screen/trigger_app_screen.dart';
import 'package:focus_flip/utils/launch_app.dart';

import 'states/begin_intervention_screen.dart';
import 'states/intervention_in_progress_screen.dart';
import 'states/intervention_interrupted_screen.dart';
import 'states/intervention_successful_screen.dart';
import 'states/intervention_timeout_screen.dart';
import 'states/waiting_for_intervention_result_screen.dart';

class InterventionScreen extends StatefulWidget {
  const InterventionScreen({super.key, required this.mainScreenCubit});

  final MainScreenCubit mainScreenCubit;

  @override
  State<InterventionScreen> createState() => _InterventionScreenState();
}

class _InterventionScreenState extends State<InterventionScreen> {
  InterventionScreenCubit _cubit = InterventionScreenCubit.instance;

  void _cubitListener(InterventionScreenState state) {
    if (state is PopInterventionScreen) {
      if (mounted) {
        print("[InterventionScreen] Popping InterventionScreen");
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _cubit.markAsOpened();
    _cubit.stream.listen(_cubitListener);
  }

  @override
  void dispose() {
    _cubit.markAsClosed();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterventionScreenCubit, InterventionScreenState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is BeginIntervention) {
          return BeginInterventionScreen(
            triggerApp: state.triggerApp,
            healthyApp: state.healthyApp,
            reqiredHealthyTime: state.requiredHealthyTime,
            startHealthyAppIntervention: () =>
                _cubit.launchHealthyAppAsIntervention(state.healthyApp,
                    state.requiredHealthyTime, state.triggerApp),
          );
        } else if (state is InterventionInProgress) {
          return InterventionInProgressScreen(healthyApp: state.healthyApp);
        } else if (state is WaitingForInterventionResult) {
          return WaitingForInterventionResultScreen();
        } else if (state is InterventionSuccessful) {
          return InterventionSuccessfulScreen(
            triggerApp: state.triggerApp,
            healthyApp: state.healthyApp,
            requiredHealthyTime: state.requiredHealthyTime,
            ignoreRewardAndLaunchHealthyApp: () {
              launchApp(state.healthyApp);
            },
            launchTriggerApp: () {
              _cubit.launchTriggerApp(state.triggerApp);
            },
          );
        } else if (state is InterventionInterrupted) {
          return InterventionInterruptedScreen(
            triggerApp: state.triggerApp,
            healthyApp: state.healthyApp,
            requiredUsageDuration: state.requiredHealthyTime,
            restartHealthyAppIntervention: () =>
                _cubit.launchHealthyAppAsIntervention(state.healthyApp,
                    state.requiredHealthyTime, state.triggerApp),
          );
        } else if (state is InterventionResultTimeout) {
          return InterventionTimeoutScreen(
            healthyApp: state.healthyApp,
            openHealthyAppShortcutsInstructions: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return HealthyAppScreen(
                    mainScreenCubit: widget.mainScreenCubit);
              }));
            },
          );
        } else if (state is InterventionHealthyAppMissing) {
          return HealthyAppMissingIntervention(
            openHealthyAppSettings: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return HealthyAppScreen(
                    mainScreenCubit: widget.mainScreenCubit);
              }));
            },
            triggerApp: state.triggerApp,
          );
        } else if (state is InterventionTriggerAppNotSelected) {
          return TriggerAppNotSelectedIntervention(openTriggerAppSettings: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return TriggerAppScreen(mainScreenCubit: widget.mainScreenCubit);
            }));
          });
        } else {
          throw Exception("Unknown state: $state");
        }
      },
    );
  }
}
