import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy/cubits/intervention_screen/intervention_screen_cubit.dart';
import 'package:quezzy/models/app.dart';
import 'package:quezzy/repositories/main_repository.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Intervention"),
        ),
        body: BlocBuilder<InterventionScreenCubit, InterventionScreenState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is BeginIntervention) {
              return BeginInterventionScreen(
                  triggerApp: _triggerApp,
                  healthyApp: _healthyApp,
                  cubit: _cubit);
            } else if (state is InterventionInProgress) {
              return InterventionInProgressScreen(healthyApp: _healthyApp);
            } else if (state is WaitingForInterventionResult) {
              return WaitingForInterventionResultScreen();
            } else if (state is InterventionSuccessful) {
              return InterventionSuccessfulScreen(
                  triggerApp: _triggerApp,
                  healthyApp: _healthyApp,
                  cubit: _cubit);
            } else if (state is InterventionInterrupted) {
              return InterventionInterruptedScreen(
                  triggerApp: _triggerApp,
                  healthyApp: _healthyApp,
                  cubit: _cubit);
            } else if (state is InterventionResultTimeout) {
              return InterventionTimeoutScreen();
            } else {
              _cubit.closeScreen();
              return const SizedBox();
            }
          },
        ));
  }
}

class BeginInterventionScreen extends StatelessWidget {
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;
  final InterventionScreenCubit cubit;

  const BeginInterventionScreen(
      {super.key,
      required this.triggerApp,
      required this.healthyApp,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You are using ${triggerApp.name}",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            cubit.launchHealthyAppAsIntervention(healthyApp, triggerApp);
          },
          child: Text("Open " + healthyApp.name),
        ),
      ],
    ));
  }
}

class InterventionInProgressScreen extends StatelessWidget {
  final HealthyApp healthyApp;
  const InterventionInProgressScreen({super.key, required this.healthyApp});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Opening ${healthyApp.name}...",
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ));
  }
}

class WaitingForInterventionResultScreen extends StatelessWidget {
  const WaitingForInterventionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Waiting...",
        ),
      ],
    ));
  }
}

class InterventionSuccessfulScreen extends StatelessWidget {
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;
  final InterventionScreenCubit cubit;

  const InterventionSuccessfulScreen(
      {super.key,
      required this.triggerApp,
      required this.healthyApp,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You can now use ${triggerApp.name} or continue using ${healthyApp.name}"
          " if you want to continue being productive.",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            cubit.launchHealthyApp(healthyApp);
          },
          child: Text("Continue with " + healthyApp.name),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            cubit.launchTriggerApp(triggerApp);
          },
          child: Text("Open " + triggerApp.name),
        ),
      ],
    ));
  }
}

class InterventionInterruptedScreen extends StatelessWidget {
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;
  final InterventionScreenCubit cubit;

  const InterventionInterruptedScreen(
      {super.key,
      required this.triggerApp,
      required this.healthyApp,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You have used ${healthyApp.name} not long enough to be productive,"
          "so you can not use ${triggerApp.name} yet.",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            cubit.launchHealthyAppAsIntervention(healthyApp, triggerApp);
          },
          child: Text("Open " + healthyApp.name),
        ),
      ],
    ));
  }
}

class InterventionTimeoutScreen extends StatelessWidget {
  const InterventionTimeoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You probably forgot to set a shortcut for a healthy app.",
        ),
      ],
    ));
  }
}
