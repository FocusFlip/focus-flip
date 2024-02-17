import 'package:flutter/material.dart';

class WaitingForInterventionResultScreen extends StatelessWidget {
  const WaitingForInterventionResultScreen({super.key});

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
              "Waiting...",
            ),
          ],
        )));
  }
}
