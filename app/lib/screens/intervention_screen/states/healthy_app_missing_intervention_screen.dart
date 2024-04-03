import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/screens/intervention_screen/components/intervention_screen_template.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class HealthyAppMissingIntervention extends StatelessWidget {
  final void Function() openHealthyAppSettings;
  final TriggerApp triggerApp;

  const HealthyAppMissingIntervention(
      {super.key,
      required this.openHealthyAppSettings,
      required this.triggerApp});

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
          Images.illustrationOne,
          fit: BoxFit.fitWidth,
        ),
        titleText: "Healthy app missing",
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
                    text: "FocusFlip detected that you opened ",
                  ),
                  TextSpan(
                    text: triggerApp.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: " but you don't have a healthy app set. "
                          "\n\nFocusFlip helps you to reduce social media usage "
                          "by changing your habits to usage of healthy apps. "
                          "That is why, you need to set a healthy app."),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*Expanded(
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
                  SizedBox(width: ScreenUtil().setWidth(16)),*/
                  Expanded(
                    child: widgetButton(
                      widgetText("Set your healthy app",
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                      openHealthyAppSettings,
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
