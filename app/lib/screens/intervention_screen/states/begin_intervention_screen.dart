import 'package:flutter/material.dart';

import '../../../models/app.dart';

class BeginInterventionScreen extends StatelessWidget {
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;
  final void Function() startHealthyAppIntervention;

  const BeginInterventionScreen(
      {super.key,
      required this.triggerApp,
      required this.healthyApp,
      required this.startHealthyAppIntervention});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Intervention"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You are using ${triggerApp.name}",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startHealthyAppIntervention,
              child: Text("Open " + healthyApp.name),
            ),
          ],
        )));
  }
}
