import 'package:flutter/material.dart';

import '../../../cubits/intervention_screen/intervention_screen_cubit.dart';
import '../../../models/app.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Intervention"),
        ),
        body: Center(
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
        )));
  }
}
