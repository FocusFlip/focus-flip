import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/models/app.dart';

import '../../../utils/images.dart';
import '../../../utils/widget_assets.dart';
import '../components/intervention_screen_template.dart';

class InterventionTimeoutScreen extends StatelessWidget {
  const InterventionTimeoutScreen(
      {super.key,
      required this.healthyApp,
      required this.openHealthyAppShortcutsInstructions});

  final HealthyApp healthyApp;
  final void Function() openHealthyAppShortcutsInstructions;

  @override
  Widget build(BuildContext context) {
    return InterventionScreenTemplate(
        illustartion: SvgPicture.asset(
          Images.illustrationOnboardingOne,
          fit: BoxFit.fitWidth,
        ),
        titleText:
            "We can't determine how long " + healthyApp.name + " has been used",
        subtitleText: "Timeout",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(16)),
            widgetRichText(
              context,
              TextSpan(
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: "FocusFlip uses ",
                  ),
                  TextSpan(
                    text: "iOS Shortcuts ",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                      text:
                          "to track the usage of healthy apps and unlock addictive trigger apps."
                          "\n\n"
                          "Probably, the required shortcut has not been properly set for "),
                  TextSpan(
                      text: healthyApp.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text:
                        ". Follow instructions to complete the required settings.",
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: widgetButton(
                      widgetText("Open instructions",
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                      openHealthyAppShortcutsInstructions,
                      height: 56.0,
                      width: 200.0,
                      radius: 20.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
