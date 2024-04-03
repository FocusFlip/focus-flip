import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flip/cubits/intervention_screen/intervention_screen_cubit.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/main_repository.dart';

import 'state_views/begin_intervention_screen.dart';
import 'state_views/intervention_in_progress_screen.dart';
import 'state_views/intervention_interrupted_screen.dart';
import 'state_views/intervention_successful_screen.dart';
import 'state_views/intervention_timeout_screen.dart';
import 'state_views/waiting_for_intervention_result_screen.dart';

class InterventionScreen extends StatefulWidget {
  const InterventionScreen({super.key, required this.initialTriggerApp});

  final TriggerApp initialTriggerApp;

  @override
  State<InterventionScreen> createState() => _InterventionScreenState();
}

class _InterventionScreenState extends State<InterventionScreen> {
  InterventionScreenCubit _cubit = InterventionScreenCubit.instance;
  late TriggerApp _triggerApp;
  late HealthyApp _healthyApp;

  void _cubitListener(InterventionScreenState state) {
    if (state is PopInterventionScreen) {
      if (mounted) {
        print("[InterventionScreen] Popping InterventionScreen");
        Navigator.of(context).pop();
      }
    }
    if (state is InterventionScreenOpened) {
      _triggerApp = state.triggerApp;
      _healthyApp = state.healthyApp;
    }
  }

  @override
  void initState() {
    super.initState();

    _triggerApp = widget.initialTriggerApp;
    _healthyApp = MainRepository.instance.healthyApp;
    _cubit.markAsOpened(widget.initialTriggerApp);
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
            triggerApp: _triggerApp,
            healthyApp: _healthyApp,
            startHealthyAppIntervention: () =>
                _cubit.launchHealthyAppAsIntervention(_healthyApp, _triggerApp),
          );
        } else if (state is InterventionInProgress) {
          return InterventionInProgressScreen(healthyApp: _healthyApp);
        } else if (state is WaitingForInterventionResult) {
          return WaitingForInterventionResultScreen();
        } else if (state is InterventionSuccessful) {
          return InterventionSuccessfulScreen(
            triggerApp: _triggerApp,
            healthyApp: _healthyApp,
            ignoreRewardAndLaunchHealthyApp: () {
              _cubit.launchApp(_healthyApp);
            },
            launchTriggerApp: () {
              _cubit.launchTriggerApp(_triggerApp);
            },
          );
        } else if (state is InterventionInterrupted) {
          return InterventionInterruptedScreen(
            triggerApp: _triggerApp,
            healthyApp: _healthyApp,
            restartHealthyAppIntervention: () =>
                _cubit.launchHealthyAppAsIntervention(_healthyApp, _triggerApp),
          );
        } else if (state is InterventionResultTimeout) {
          return InterventionTimeoutScreen(
            healthyApp: _healthyApp,
            openHealthyAppShortcutsInstructions: () {
              // TODO: implement
              throw Exception("Not implemented");
            },
          );
        } else {
          _cubit.closeScreen();
          return const SizedBox();
        }
      },
    );
  }
}
