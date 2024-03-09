import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/screens/intervention_screen/components/intervention_screen_template.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class TriggerAppNotSelectedIntervention extends StatelessWidget {
  final void Function() openTriggerAppSettings;

  const TriggerAppNotSelectedIntervention(
      {super.key, required this.openTriggerAppSettings});

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
        titleText: "Shortcut automation invalid",
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
                  TextSpan(text: 'FocusFlip Shortcut automation '),
                  TextSpan(
                      text: "Trigger App Opened",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(
                      text:
                          '  has been executed, but the trigger app selected in '
                          'the shortcut was not found across the apps, you '
                          'added to the list of trigger apps.'
                          '\n\nPlease, open the trigger apps settings and add'
                          ' check if all the steps were followed correctly.'),
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
                      widgetText("Open settings",
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                      openTriggerAppSettings,
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
