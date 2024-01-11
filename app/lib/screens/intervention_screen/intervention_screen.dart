import 'package:flutter/material.dart';
import 'package:quezzy/cubits/intervention_screen/intervention_screen_cubit.dart';

class InterventionScreen extends StatefulWidget {
  const InterventionScreen({super.key});

  @override
  State<InterventionScreen> createState() => _InterventionScreenState();
}

class _InterventionScreenState extends State<InterventionScreen> {
  InterventionScreenCubit _cubit = InterventionScreenCubit.instance;

  @override
  void initState() {
    super.initState();

    _cubit.markAsOpened();
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
