import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/app.dart';
import '../components/intervention_screen_template.dart';

class InterventionInProgressScreen extends StatelessWidget {
  final HealthyApp healthyApp;
  const InterventionInProgressScreen({super.key, required this.healthyApp});

  @override
  Widget build(BuildContext context) {
    return InterventionScreenTemplate(
        illustartion: SizedBox.shrink(),
        titleText: "Opening " + healthyApp.name + "...",
        subtitleText: "Flip your Focus",
        body: Container(
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(100),
          child: CircularProgressIndicator(),
        ));
  }
}
