import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:focus_flip/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

import '../../utils/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Login', color: Colors.black),
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
                            child: widgetText("Login with Google",
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
                            child: widgetText("Login with Facebook",
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16))),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(36)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 135,
                      height: 1,
                      color: const Color.fromRGBO(230, 230, 230, 1),
                    ),
                    Container(
                      child: widgetText('OR',
                          color: const Color.fromRGBO(133, 132, 148, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                    Container(
                      width: 135,
                      height: 1,
                      color: const Color.fromRGBO(230, 230, 230, 1),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgetText('Email Address',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(8),
                      ),
                      child: TextFormField(
                        onTap: () {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline,
                              color: ColorsHelpers.primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(19),
                          ),
                          hintText: 'Your Email Address',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgetText('Password',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(8),
                      ),
                      child: TextFormField(
                        onTap: () {},
                        obscureText: _obscured,
                        focusNode: textFieldFocusNode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline,
                              color: ColorsHelpers.primaryColor),
                          suffixIcon: GestureDetector(
                            onTap: _toggleObscured,
                            child: Icon(
                              _obscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 24,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(19),
                          ),
                          hintText: 'Your Password',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    bottom: ScreenUtil().setHeight(24)),
                child: widgetButton(
                    widgetText('Login',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16)),
                    height: 56.0,
                    radius: 20.0,
                    width: MediaQuery.of(context).size.width,
                    () => null),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                child: GestureDetector(
                  child: widgetText('Forgot password?',
                      color: ColorsHelpers.primaryColor,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: "By continuing, you agree to the ",
                        style:
                            TextStyle(color: Color.fromRGBO(133, 132, 148, 1))),
                    TextSpan(
                      text: 'Terms of Services ',
                      style: TextStyle(color: Color.fromRGBO(73, 70, 95, 1)),
                    ),
                    TextSpan(
                        text: '& ',
                        style:
                            TextStyle(color: Color.fromRGBO(133, 132, 148, 1))),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Color.fromRGBO(73, 70, 95, 1)),
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
