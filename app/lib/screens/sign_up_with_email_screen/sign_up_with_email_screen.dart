import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:focus_flip/screens/bottom_nav_bar.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class SignUpWithEmailScreen extends StatefulWidget {
  const SignUpWithEmailScreen({Key? key}) : super(key: key);

  @override
  State<SignUpWithEmailScreen> createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {
  bool isStep1 = false;
  bool isStep2 = false;
  bool isStep3 = false;

  bool isValidPass = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _usernameController = TextEditingController();

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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(239, 238, 252, 1),
        elevation: 0,
        title: widgetText(
            !isStep1
                ? 'What\'s your email?'
                : !isStep2
                    ? 'What\'s your password?'
                    : 'Create a username',
            color: Colors.black),
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
              !isStep1
                  ? Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
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
                              controller: _emailController,
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
                    )
                  : !isStep2
                      ? Container(
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(24),
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
                                  controller: _passController,
                                  onTap: () {},
                                  obscureText: _obscured,
                                  focusNode: textFieldFocusNode,
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.length > 7) {
                                        isValidPass = true;
                                      } else {
                                        isValidPass = false;
                                      }
                                    });
                                  },
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
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(19),
                                    ),
                                    hintText: 'Your Password',
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(8)),
                                    child: widgetText(
                                      'Must be at least 8 characters.',
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: const Color.fromRGBO(
                                          133, 132, 148, 1),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(8)),
                                    child: Icon(
                                      isValidPass
                                          ? Icons.check
                                          : Icons.highlight_off_sharp,
                                      color: isValidPass
                                          ? ColorsHelpers.primaryColor
                                          : Colors.red,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widgetText('Username',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(8),
                                ),
                                child: TextFormField(
                                  controller: _usernameController,
                                  onTap: () {},
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail_outline,
                                        color: ColorsHelpers.primaryColor),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(19),
                                    ),
                                    hintText: 'Your username',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(205)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: 12, bottom: ScreenUtil().setHeight(8)),
                      child: widgetText(
                          !isStep1
                              ? '1 of 3'
                              : !isStep2
                                  ? '2 of 3'
                                  : '3 of 3',
                          color: ColorsHelpers.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * .85,
                      lineHeight: ScreenUtil().setHeight(8),
                      percent: !isStep1
                          ? 0.4
                          : !isStep2
                              ? 0.7
                              : 1,
                      animation: true,
                      barRadius: const Radius.circular(8),
                      backgroundColor:
                          ColorsHelpers.primaryColor.withOpacity(0.10),
                      progressColor: ColorsHelpers.primaryColor,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    bottom: ScreenUtil().setHeight(24)),
                child: widgetButton(
                    widgetText(
                        !isStep1
                            ? 'Continue'
                            : !isStep2
                                ? 'Continue'
                                : 'Submit',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16)),
                    radius: 20.0,
                    height: 56.0,
                    width: MediaQuery.of(context).size.width, () {
                  if (isStep1 == false) {
                    setState(() {
                      isStep1 = true;
                    });
                  } else if (isStep2 == false) {
                    if (_passController.text.length > 7) {
                      setState(() {
                        isStep2 = true;
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Password atleast 8 characters",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0);
                    }
                  } else if (isStep3 == false) {
                    isStep3 = true;
                    setState(() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const BottomNavScreen();
                          },
                        ),
                        (route) => false,
                      );
                    });
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
