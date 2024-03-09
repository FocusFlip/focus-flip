import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/app.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../../utils/widget_assets.dart';
import '../components/intervention_screen_template.dart';

class InterventionSuccessfulScreen extends StatelessWidget {
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;
  final Duration requiredHealthyTime;
  final void Function() ignoreRewardAndLaunchHealthyApp;
  final void Function() launchTriggerApp; // Reward

  const InterventionSuccessfulScreen({
    super.key,
    required this.triggerApp,
    required this.healthyApp,
    required this.requiredHealthyTime,
    required this.ignoreRewardAndLaunchHealthyApp,
    required this.launchTriggerApp,
  });

  @override
  Widget build(BuildContext context) {
    return InterventionScreenTemplate(
        /*illustartion: ClipRect(
            child: SizedBox(
                height: 300,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                        top: ScreenUtil().setWidth(-90),
                        left: ScreenUtil().setWidth(-100),
                        right: ScreenUtil().setWidth(-20),
                        child: SvgPicture.asset(
                          Images.illustrationTwo,
                          fit: BoxFit.fitWidth,
                        ))
                  ],
                ))),*/
        illustartion: SvgPicture.asset(
          Images.illustrationKey,
          fit: BoxFit.fitWidth,
        ),
        titleText: "One step closer to your goal!",
        subtitleText: "Flip your Focus",
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
                    text: "You have already been using ",
                  ),
                  TextSpan(
                    text: healthyApp.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " for ",
                  ),
                  TextSpan(
                    text: requiredHealthyTime.inSeconds.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' seconds and unlocked ',
                  ),
                  TextSpan(
                    text: triggerApp.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ". You can also just ",
                  ),
                  TextSpan(
                      text: "flip your focus ",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(text: "to "),
                  TextSpan(
                    text: healthyApp.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " completely. What do you want?")
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
                        widgetText(triggerApp.name,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                            color: ColorsHelpers.primaryColor),
                        launchTriggerApp,
                        height: 56.0,
                        width: 142.0,
                        radius: 20.0,
                        colorBorder: ColorsHelpers.secondLavender,
                        color: Colors.white,
                        widthBorder: 1.0),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(16)),
                  Expanded(
                    child: widgetButton(
                      widgetText(healthyApp.name,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                      ignoreRewardAndLaunchHealthyApp,
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
