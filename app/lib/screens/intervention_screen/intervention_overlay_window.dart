import 'package:flutter/material.dart';
import 'package:overlay_pop_up/overlay_communicator.dart';
import 'package:quezzy/models/app.dart';
import 'package:quezzy/screens/intervention_screen/intervention_screen.dart';

class InterventionOverlayWindow extends StatefulWidget {
  const InterventionOverlayWindow({super.key});

  static const String REQUEST_INTERVENTION_DATA = "REQUEST_INTERVENTION_DATA";
  static const String LAUNCH_HEALTHY_APP_INTERVENTION =
      "LAUNCH_HEALTHY_APP_INTERVENTION";
  static const String IGNORE_REWARD_AND_LAUNCH_HEALTHY_APP =
      "IGNORE_REWARD_AND_LAUNCH_HEALTHY_APP";
  static const String LAUNCH_TRIGGER_APP = "LAUNCH_TRIGGER_APP";

  static const String BEGIN_INTERVENTION_STATE = "BEGIN_INTERVENTION_STATE";
  static const String INTERVENTION_SUCCESSFUL_STATE =
      "INTERVENTION_SUCCESSFUL_STATE";

  @override
  State<InterventionOverlayWindow> createState() =>
      _InterventionOverlayWindowState();
}

class _InterventionOverlayWindowState extends State<InterventionOverlayWindow> {
  HealthyApp? _healthyApp;
  TriggerApp? _triggerApp;
  String? _stateName;

  bool get _isInterventionDataAvailable =>
      _healthyApp != null && _triggerApp != null && _stateName != null;

  @override
  void initState() {
    super.initState();

    OverlayCommunicator.instance.onMessage?.listen(_overlayDataListener);
    OverlayCommunicator.instance
        .send(InterventionOverlayWindow.REQUEST_INTERVENTION_DATA);
  }

  void _overlayDataListener(dynamic event) {
    assert(event is Map);
    assert(event["state"] is String);
    assert(event["triggerApp"] is Map);
    assert(event["healthyApp"] is Map);
    _stateName = event["state"];
    _triggerApp = TriggerApp.fromJson(event["triggerApp"]);
    _healthyApp = HealthyApp.fromJson(event["healthyApp"]);
    setState(() {});
  }

  void _clearInterventionData() {
    _healthyApp = null;
    _triggerApp = null;
    _stateName = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget body = CircularProgressIndicator();

    if (_isInterventionDataAvailable) {
      assert(_stateName == InterventionOverlayWindow.BEGIN_INTERVENTION_STATE ||
          _stateName ==
              InterventionOverlayWindow.INTERVENTION_SUCCESSFUL_STATE);
      if (_stateName == InterventionOverlayWindow.BEGIN_INTERVENTION_STATE) {
        body = BeginInterventionScreen(
          triggerApp: _triggerApp!,
          healthyApp: _healthyApp!,
          startHealthyAppIntervention: () {
            _clearInterventionData();
            OverlayCommunicator.instance.send(
                InterventionOverlayWindow.LAUNCH_HEALTHY_APP_INTERVENTION);
          },
        );
      } else if (_stateName ==
          InterventionOverlayWindow.INTERVENTION_SUCCESSFUL_STATE) {
        body = InterventionSuccessfulScreen(
          triggerApp: _triggerApp!,
          healthyApp: _healthyApp!,
          ignoreRewardAndLaunchHealthyApp: () {
            _clearInterventionData();
            OverlayCommunicator.instance.send(
                InterventionOverlayWindow.IGNORE_REWARD_AND_LAUNCH_HEALTHY_APP);
          },
          launchTriggerApp: () {
            _clearInterventionData();
            OverlayCommunicator.instance
                .send(InterventionOverlayWindow.LAUNCH_TRIGGER_APP);
          },
        );
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("Intervention")), body: Center(child: body));
  }
}
