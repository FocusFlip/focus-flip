import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quezzy/screens/login_screen/login_screen.dart';
import 'package:quezzy/screens/sign_up_screen/sign_up_screen.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class LoginOptionScreen extends StatefulWidget {
  const LoginOptionScreen({Key? key}) : super(key: key);

  @override
  State<LoginOptionScreen> createState() => _LoginOptionScreenState();
}

class _LoginOptionScreenState extends State<LoginOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorsHelpers.primaryColor,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 56, top: 218),
                      child: SvgPicture.asset(Images.ovalBig),
                    ),
                    SvgPicture.asset(Images.ovalWithOutlineTop)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Images.ovalWithOutlineBottom),
                    Padding(
                      padding: const EdgeInsets.only(right: 80, bottom: 100),
                      child: SvgPicture.asset(Images.ovalMini),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      Images.appLogo,
                      height: ScreenUtil().setHeight(56),
                      width: ScreenUtil().setWidth(50),
                    ),
                  ),
                  Image.asset(
                    Images.appLogo,
                    width: 75,
                    height: 96,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(Images.man2),
                      SvgPicture.asset(Images.man1),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(16),
                    right: ScreenUtil().setWidth(16)),
                height: ScreenUtil().setHeight(340),
                width: ScreenUtil().setWidth(343),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                      child: widgetText('Login or Sign Up',
                          fontSize: ScreenUtil().setSp(22),
                          letterSpacing: -1,
                          color: const Color.fromRGBO(0, 24, 51, 1)),
                    ),
                    Container(
                      child: widgetText(
                          'Login or create an account to take quiz, take part in challenge, and more.',
                          fontSize: ScreenUtil().setSp(16),
                          color: const Color.fromRGBO(133, 132, 148, 1),
                          fontWeight: FontWeight.w400,
                          align: TextAlign.center),
                    ),
                    widgetButton(
                        widgetText('Login', color: Colors.white),
                        width: ScreenUtil().setWidth(311),
                        height: ScreenUtil().setHeight(56),
                        radius: 20.0,
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()))),
                    widgetButton(
                        widgetText('Create an account',
                            color: ColorsHelpers.primaryColor),
                        color: const Color.fromRGBO(239, 238, 252, 1),
                        width: ScreenUtil().setWidth(311),
                        height: ScreenUtil().setHeight(56),
                        radius: 20.0,
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()))),
                    Container(
                      child: widgetText(
                        'Later',
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(133, 132, 148, 1),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
