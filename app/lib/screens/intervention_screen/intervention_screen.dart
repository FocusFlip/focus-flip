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
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You are using ${_triggerApp.name}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _cubit.launchHealthyApp(_healthyApp, _triggerApp);
                  },
                  child: Text("Open " + _healthyApp.name),
                ),
              ],
            ));
          },
        ));
  }
}
