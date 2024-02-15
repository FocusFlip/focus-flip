import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({Key? key}) : super(key: key);

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Invite Friends',
            color: Colors.white,
            fontSize: ScreenUtil().setSp(24),
            fontWeight: FontWeight.w500),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
          child: const BackButton(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(24)),
        color: ColorsHelpers.primaryColor,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
              color: ColorsHelpers.dullLavender),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(Images.inviteFriendRound),
                  widgetText(
                    'VS',
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w700,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          Images.leaderboardAvatar5,
                          width: ScreenUtil().setSp(64),
                          height: ScreenUtil().setSp(64),
                        ),
                        SvgPicture.asset(
                          Images.leaderboardAvatar2,
                          width: ScreenUtil().setSp(64),
                          height: ScreenUtil().setSp(64),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: Offset(0, ScreenUtil().setHeight(-6)),
                      child: SvgPicture.asset(
                        Images.inviteFriendCloud,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(24)),
                      child: widgetText(
                        'Invite friends and get a bonus points for every new player!',
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w500,
                        align: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(24),
                        left: ScreenUtil().setHeight(24),
                        right: ScreenUtil().setHeight(24),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(16)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromRGBO(0, 98, 204, 0.2),
                            width: ScreenUtil().setSp(2),
                          ),
                          color: ColorsHelpers.grey5),
                      child: widgetText(
                        'QU123Z',
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w700,
                        align: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(32),
                        bottom: ScreenUtil().setHeight(24),
                        left: ScreenUtil().setHeight(24),
                        right: ScreenUtil().setHeight(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    const ClipboardData(text: "QU123Z"));
                                Fluttertoast.showToast(
                                    msg: "Copied",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorsHelpers.primaryColor),
                                padding: EdgeInsets.symmetric(
                                    vertical: ScreenUtil().setHeight(16)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.paste_rounded,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(16)),
                                      child: widgetText(
                                        'Copy Code',
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w700,
                                        align: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(16)),
                            width: ScreenUtil().setWidth(56),
                            height: ScreenUtil().setWidth(56),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color.fromRGBO(106, 90, 224, 0.2),
                                width: ScreenUtil().setSp(2),
                              ),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.share_outlined,
                              color: ColorsHelpers.primaryColor,
                            ),
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
    );
  }
}
