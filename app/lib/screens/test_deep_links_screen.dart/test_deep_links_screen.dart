import 'package:flutter/material.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/predefined_app_list_repository.dart';
import 'package:focus_flip/utils/launch_app.dart';

/// This screen is used to test deep links of
/// `PredefinedAppListRepository.triggerApps` and
/// `PredefinedAppListRepository.healthyApps`.
class TestDeepLinksScreen extends StatelessWidget {
  const TestDeepLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ListTile _buildAppListTile(BuildContext context, App app) {
      return ListTile(
        title: Text(app.name),
        onTap: () {
          launchApp(app);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Test Deep Links"),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    "Click on the app name to open the app",
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Trigger Apps",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ] +
                PredefinedAppListRepository.triggerApps
                    .map((app) => _buildAppListTile(context, app))
                    .toList() +
                [
                  SizedBox(height: 20),
                  Text(
                    "Healthy Apps",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ] +
                PredefinedAppListRepository.healthyApps
                    .map((app) => _buildAppListTile(context, app))
                    .toList()),
      ),
    );
  }
}
