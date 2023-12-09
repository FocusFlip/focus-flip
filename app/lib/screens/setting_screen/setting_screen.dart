import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quezzy/screens/faq_screen/faq_screen.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';
import '../../utils/constant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final textFieldFocusNode = FocusNode();
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Settings',
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
            left: ScreenUtil().setWidth(24), right: ScreenUtil().setHeight(24)),
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(104)),
                child: widgetText(
                  'ACCOUNT',
                  color: ColorsHelpers.neutralOpacity0_5,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500,
                  letterSpacing: ScreenUtil().setSp(1.2),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                    color: ColorsHelpers.grey5),
                child: Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(44),
                      height: ScreenUtil().setWidth(44),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: ColorsHelpers.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widgetText(
                            'Update Profile',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                          Text(
                            'Update username, country, etc',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                                color: ColorsHelpers.grey2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                      child: Icon(Icons.arrow_forward_ios,
                          size: ScreenUtil().setSp(20)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                    color: ColorsHelpers.grey5),
                child: Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(44),
                      height: ScreenUtil().setWidth(44),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                      child: Icon(
                        Icons.mail_outline_rounded,
                        color: ColorsHelpers.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widgetText(
                            'Change Email Address',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                          Text(
                            'madias@yahoo.com',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                                color: ColorsHelpers.grey2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                      child: Icon(Icons.arrow_forward_ios,
                          size: ScreenUtil().setSp(20)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                    color: ColorsHelpers.grey5),
                child: Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(44),
                      height: ScreenUtil().setWidth(44),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        color: ColorsHelpers.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widgetText(
                            'Change Password',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                          Text(
                            'last change 1 year ago',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                                color: ColorsHelpers.grey2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                      child: Icon(Icons.arrow_forward_ios,
                          size: ScreenUtil().setSp(20)),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                child: widgetText(
                  'OTHER',
                  color: ColorsHelpers.neutralOpacity0_5,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500,
                  letterSpacing: ScreenUtil().setSp(1.2),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widgetText(
                      'Notification',
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                    ),
                    CupertinoSwitch(
                      value: _switchValue,
                      activeColor: ColorsHelpers.primaryColor,
                      onChanged: ((bool value) {
                        setState(() {
                          _switchValue = value;
                        });
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                    color: ColorsHelpers.grey5),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(44),
                      height: ScreenUtil().setWidth(44),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                      child: SvgPicture.asset(
                        Images.jigsaw,
                        width: ScreenUtil().setWidth(24),
                        height: ScreenUtil().setWidth(24),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widgetText(
                            'Change Difficulty',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                          Text(
                            'Easy, normal, hard',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                                color: ColorsHelpers.grey2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                      child: Icon(Icons.arrow_forward_ios,
                          size: ScreenUtil().setSp(20)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FaqScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(20)),
                      color: ColorsHelpers.grey5),
                  child: Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(44),
                          height: ScreenUtil().setWidth(44),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                          child: Icon(
                            Icons.question_mark_sharp,
                            color: ColorsHelpers.primaryColor,
                          )),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widgetText(
                              'FAQ',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                            Text(
                              'Most frequently asked question',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w400,
                                  color: ColorsHelpers.grey2),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                        child: Icon(Icons.arrow_forward_ios,
                            size: ScreenUtil().setSp(20)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(32),
                  bottom: ScreenUtil().setHeight(56),
                ),
                child: widgetText(
                  'Logout',
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
