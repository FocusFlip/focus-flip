import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/intervention_screen_template.dart';

class WaitingForInterventionResultScreen extends StatelessWidget {
  const WaitingForInterventionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InterventionScreenTemplate(
        illustartion: SizedBox.shrink(),
        titleText: "Loading...",
        subtitleText: "Flip your Focus",
        body: Container(
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(100),
          child: CircularProgressIndicator(),
        ));
  }
}
