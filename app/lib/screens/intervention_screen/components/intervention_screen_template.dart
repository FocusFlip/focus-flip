import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../../utils/widget_assets.dart';

class InterventionScreenTemplate extends StatelessWidget {
  const InterventionScreenTemplate({
    super.key,
    required this.illustartion,
    required this.titleText,
    required this.subtitleText,
    required this.body,
  });

  final Widget illustartion;
  final Widget body;
  final String titleText;
  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: ColorsHelpers.primaryColor,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 50,
                  child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(180 / 360),
                      child: SvgPicture.asset(
                        Images.ovalWithOutlineBottomOnboarding,
                        height: ScreenUtil().setHeight(200),
                        width: ScreenUtil().setWidth(200),
                        fit: BoxFit.fitHeight,
                      )),
                ),
                Positioned(top: 250, child: Image.asset(Images.ovalTwoBig)),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).viewPadding.vertical),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            2 * MediaQuery.of(context).viewPadding.vertical),
                    child: Column(
                      children: [
                        illustartion,
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(24),
                            right: ScreenUtil().setWidth(16),
                            left: ScreenUtil().setWidth(16),
                            bottom: ScreenUtil().setHeight(24),
                          ),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(8)),
                                child: widgetText(subtitleText.toUpperCase(),
                                    color: ColorsHelpers.grey2,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2),
                              ),
                              widgetText(titleText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(20),
                                  color: Colors.black),
                              body,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
