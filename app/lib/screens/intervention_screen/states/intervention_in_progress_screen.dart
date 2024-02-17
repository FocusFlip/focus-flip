import 'package:flutter/material.dart';

import '../../../models/app.dart';

class InterventionInProgressScreen extends StatelessWidget {
  final HealthyApp healthyApp;
  const InterventionInProgressScreen({super.key, required this.healthyApp});

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
              "Opening ${healthyApp.name}...",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        )));
  }
}
