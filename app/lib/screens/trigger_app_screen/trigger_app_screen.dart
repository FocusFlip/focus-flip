import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class TriggerAppScreen extends StatelessWidget {
  TriggerAppScreen({super.key});

  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Trigger App',
            color: Colors.black,
            fontSize: ScreenUtil().setSp(24),
            fontWeight: FontWeight.w500),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
          child: const BackButton(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(8), right: ScreenUtil().setHeight(8)),
        color: ColorsHelpers.grey5,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(104)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                color: Colors.white),
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Transform.translate(
                        offset: Offset(0, ScreenUtil().setHeight(-6.1)),
                        child: SvgPicture.asset(Images.quizWhiteVector),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(8),
                        height: ScreenUtil().setHeight(8),
                        decoration: BoxDecoration(
                          color: ColorsHelpers.grey5,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  child: widgetText(
                    '1. Select a trigger app',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'Queezy apps offer gamified quizzes with many different topics to test out your knowledge.',
                    color: ColorsHelpers.grey1,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  child: widgetText(
                    '2. Setup a Shortcut automation',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'With Queezy you can also take part in challenges with friends or against others.',
                    color: ColorsHelpers.grey1,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil()
                      .setHeight(MediaQuery.of(context).size.width / 2 - 35),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(Images.background1),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(Images.playButton),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          bottom: ScreenUtil().setHeight(16),
                          top: ScreenUtil().setHeight(36),
                        ),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(20)),
                            color: const Color.fromRGBO(242, 247, 253, 0.7)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widgetText(
                              'Watch on',
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(4)),
                              child: SvgPicture.asset(Images.youtube),
                            ),
                            widgetText(
                              'YouTube',
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
