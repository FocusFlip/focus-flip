import 'package:flutter/material.dart';

import '../../../models/app.dart';

class InterventionSuccessfulScreen extends StatelessWidget {
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;
  final void Function() ignoreRewardAndLaunchHealthyApp;
  final void Function() launchTriggerApp; // Reward

  const InterventionSuccessfulScreen({
    super.key,
    required this.triggerApp,
    required this.healthyApp,
    required this.ignoreRewardAndLaunchHealthyApp,
    required this.launchTriggerApp,
  });

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
              "You can now use ${triggerApp.name} or continue using ${healthyApp.name}"
              " if you want to continue being productive.",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ignoreRewardAndLaunchHealthyApp,
              child: Text("Continue with " + healthyApp.name),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: launchTriggerApp,
              child: Text("Open " + triggerApp.name),
            ),
          ],
        )));
  }
}
