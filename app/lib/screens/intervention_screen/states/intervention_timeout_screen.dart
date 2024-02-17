import 'package:flutter/material.dart';

class InterventionTimeoutScreen extends StatelessWidget {
  const InterventionTimeoutScreen({super.key});

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
              "You probably forgot to set a shortcut for a healthy app.",
            ),
          ],
        )));
  }
}
