import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quezzy/screens/faq_detail_screen/faq_detail_screen.dart';
import 'package:quezzy/screens/invite_friend_screen/invite_friend_screen.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Help and Support',
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
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  child: TextFormField(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      TextEditingController().clear();
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(16)),
                        child: SvgPicture.asset(Images.search),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: ScreenUtil().setWidth(56),
                        maxHeight: ScreenUtil().setWidth(24),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorsHelpers.grey5),
                          borderRadius: BorderRadius.circular(20.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorsHelpers.grey5),
                          borderRadius: BorderRadius.circular(20.0)),
                      fillColor: ColorsHelpers.grey5,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(16),
                        bottom: ScreenUtil().setWidth(16),
                        left: ScreenUtil().setWidth(24),
                        right: ScreenUtil().setWidth(24),
                      ),
                      hintText: 'Search topics or questions',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          color: ColorsHelpers.grey2),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  child: widgetText(
                    'INTRO',
                    color: ColorsHelpers.neutralOpacity0_5,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500,
                    letterSpacing: ScreenUtil().setSp(1.2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(16)),
                  child: Divider(
                    thickness: ScreenUtil().setSp(1),
                    color: ColorsHelpers.grey5,
                    height: 0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const FaqDetailScreen())));
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: widgetText(
                      'Intro to Queezy apps',
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(16)),
                  child: Divider(
                    thickness: ScreenUtil().setSp(1),
                    color: ColorsHelpers.grey5,
                    height: 0,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'How to login or sign up',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                  child: widgetText(
                    'CREATE AND TAKE QUIZ',
                    color: ColorsHelpers.neutralOpacity0_5,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500,
                    letterSpacing: ScreenUtil().setSp(1.2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(16)),
                  child: Divider(
                    thickness: ScreenUtil().setSp(1),
                    color: ColorsHelpers.grey5,
                    height: 0,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'How to create quiz in the app',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(16)),
                  child: Divider(
                    thickness: ScreenUtil().setSp(1),
                    color: ColorsHelpers.grey5,
                    height: 0,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'How to take quiz in the app',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(16)),
                  child: Divider(
                    thickness: ScreenUtil().setSp(1),
                    color: ColorsHelpers.grey5,
                    height: 0,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'How do I play quiz with other players?',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(16)),
                  child: Divider(
                    thickness: ScreenUtil().setSp(1),
                    color: ColorsHelpers.grey5,
                    height: 0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const InviteFriendScreen())));
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: widgetText(
                      'Can I invite my friends to play quiz together?',
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
