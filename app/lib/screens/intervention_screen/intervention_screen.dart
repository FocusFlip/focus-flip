import 'package:flutter/material.dart';
import 'package:quezzy/cubits/intervention_screen/intervention_screen_cubit.dart';
import 'package:quezzy/models/trigger_app.dart';

class InterventionScreen extends StatefulWidget {
  const InterventionScreen({super.key, required this.initialTriggerApp});

  final TriggerApp initialTriggerApp;

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
      body: Center(
        child: Text("Intervention"),
      ),
    );
  }
}
