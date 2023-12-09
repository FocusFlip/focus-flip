import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constant.dart';
import '../../utils/widget_assets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isClicked = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  final textFieldFocusNode2 = FocusNode();
  bool _obscured2 = false;

  bool isValidPass = false;

  final _passController = TextEditingController();

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

  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
      if (textFieldFocusNode2.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode2.canRequestFocus =
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
        title: widgetText(!isClicked ? 'Reset Password' : 'New Password',
            color: Colors.black),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(239, 238, 252, 1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: widgetText(
                  !isClicked
                      ? 'Enter your email and we will send you a link to reset your password.'
                      : 'Your new password must be different from previous used passwords.',
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  color: const Color.fromRGBO(133, 132, 148, 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isClicked
                        ? Column(
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
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
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
                          )
                        : Container(),
                    isClicked
                        ? Column(
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
                                  controller: _passController,
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.length > 7) {
                                        isValidPass = true;
                                      } else {
                                        isValidPass = false;
                                      }
                                    });
                                  },
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
                            ],
                          )
                        : Container(),
                    isClicked
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(8)),
                                child: widgetText(
                                  'Must be at least 8 characters.',
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(14),
                                  color: const Color.fromRGBO(133, 132, 148, 1),
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
                        : Container(),
                    isClicked
                        ? Container(
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widgetText('Confirm Password',
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
                                    obscureText: _obscured2,
                                    focusNode: textFieldFocusNode2,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: ColorsHelpers.primaryColor),
                                      suffixIcon: GestureDetector(
                                        onTap: _toggleObscured2,
                                        child: Icon(
                                          _obscured2
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
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          bottom: ScreenUtil().setHeight(24)),
                      child: widgetButton(
                          widgetText('Reset Password',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16)),
                          height: 56.0,
                          radius: 20.0,
                          width: MediaQuery.of(context).size.width, () {
                        setState(() {
                          isClicked = true;
                        });
                      }),
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
