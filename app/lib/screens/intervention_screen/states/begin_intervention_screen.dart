import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/screens/intervention_screen/components/circle_icon.dart';
import 'package:focus_flip/screens/intervention_screen/components/intervention_screen_template.dart';
import 'package:focus_flip/utils/images.dart';

import '../../../models/app.dart';
import '../../../utils/constant.dart';
import '../../../utils/widget_assets.dart';

class BeginInterventionScreen extends StatelessWidget {
  final TriggerApp triggerApp;
  final HealthyApp healthyApp;
  final Duration reqiredHealthyTime;
  final void Function() startHealthyAppIntervention;

  const BeginInterventionScreen(
      {super.key,
      required this.triggerApp,
      required this.healthyApp,
      required this.reqiredHealthyTime,
      required this.startHealthyAppIntervention});

  @override
  Widget build(BuildContext context) {
    return InterventionScreenTemplate(
        illustartion: ClipRect(
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
                ))),
        titleText: "It's time to learn something new!",
        subtitleText: "Flip your Focus",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil().setHeight(64),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: ColorsHelpers.grey5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: ScreenUtil().setWidth(16)),
                        CircleIcon(
                            size: ScreenUtil().setHeight(15),
                            icon: Icons.timer_outlined,
                            color: ColorsHelpers.primaryColor),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                        widgetText(
                            reqiredHealthyTime.inSeconds.toString() + ' sec',
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            fontSize: ScreenUtil().setSp(14),
                            color: Colors.black),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                      ],
                    ),
                  ),
                  Container(
                    height: 32,
                    width: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.1, 0.5, 0.9],
                        colors: [
                          Colors.grey.withOpacity(0.1),
                          Colors.grey.withOpacity(0.5),
                          Colors.grey.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: ScreenUtil().setWidth(16)),
                        CircleIcon(
                            size: ScreenUtil().setHeight(15),
                            icon: Icons.smartphone,
                            color: ColorsHelpers.pink),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                        widgetText(healthyApp.name,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            fontSize: ScreenUtil().setSp(14),
                            color: Colors.black),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                    text: "Before you can open ",
                  ),
                  TextSpan(
                    text: triggerApp.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ", you have to earn it by being productive with ",
                  ),
                  TextSpan(
                    text: healthyApp.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " for ",
                  ),
                  TextSpan(
                    text: reqiredHealthyTime.inSeconds.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' seconds',
                    style: TextStyle(),
                  ),
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
                        widgetText('Cancel',
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                            color: ColorsHelpers.primaryColor), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Container()
                              // Not supported by Flutter
                              /*const LiveQuizScreen()*/));
                    },
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
                      widgetText('Open ' + healthyApp.name,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                      startHealthyAppIntervention,
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
