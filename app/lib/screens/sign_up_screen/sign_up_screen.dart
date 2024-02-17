import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/screens/login_screen/login_screen.dart';
import 'package:focus_flip/screens/sign_up_with_email_screen/sign_up_with_email_screen.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/widget_assets.dart';

import '../../utils/images.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Sign Up', color: Colors.black),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(24), right: ScreenUtil().setHeight(24)),
        color: const Color.fromRGBO(239, 238, 252, 1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: ScreenUtil().setHeight(46),
                width: ScreenUtil().setWidth(327),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(120)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(
                              color: Color.fromRGBO(230, 230, 230, 1))),
                      backgroundColor: ColorsHelpers.primaryColor),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SignUpWithEmailScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                            flex: 1, child: Icon(Icons.mail_outline)),
                        Expanded(
                            flex: 3,
                            child: widgetText("Sign Up with Email",
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16))),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(46),
                width: ScreenUtil().setWidth(327),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(
                              color: Color.fromRGBO(230, 230, 230, 1))),
                      backgroundColor: Colors.white),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                            Images.googleIcon,
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: widgetText("Sign Up with Google",
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16))),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(46),
                width: ScreenUtil().setWidth(327),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(
                              color: Color.fromRGBO(230, 230, 230, 1))),
                      backgroundColor: const Color.fromRGBO(0, 86, 178, 1)),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                            Images.fbIcon,
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: widgetText("Sign Up with Facebook",
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16))),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    bottom: ScreenUtil().setHeight(24)),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              color: const Color.fromRGBO(133, 132, 148, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(16))),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        style: TextStyle(
                            color: ColorsHelpers.primaryColor,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "By continuing, you agree to the ",
                        style: TextStyle(
                            color: const Color.fromRGBO(133, 132, 148, 1),
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                      text: 'Terms of Services ',
                      style: TextStyle(
                          color: const Color.fromRGBO(73, 70, 95, 1),
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                        text: '& ',
                        style: TextStyle(
                            color: const Color.fromRGBO(133, 132, 148, 1),
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          color: const Color.fromRGBO(73, 70, 95, 1),
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
