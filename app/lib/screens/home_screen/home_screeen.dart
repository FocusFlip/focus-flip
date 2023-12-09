import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quezzy/screens/detail_quiz_screen/detail_quiz_screen.dart';
import 'package:quezzy/screens/setting_screen/setting_screen.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Permission.camera.request().isGranted;
    requestMultiplePermissions();

    super.initState();
  }

  void requestMultiplePermissions() async {}

  void requestCameraPermission() async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.camera.status;
    if (status.isGranted) {
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.camera.request().isGranted) {
        openAppSettings();
        // Either the permission was already granted before or the user just granted it.
      }
    }

    // You can can also directly ask the permission about its status.
    // if (await Permission.location.isRestricted) {
    //   // The OS restricts access, for example because of parental controls.
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 0.5],
                colors: [
                  ColorsHelpers.primaryColor,
                  Colors.white,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: ColorsHelpers.primaryColor,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(24),
                          right: ScreenUtil().setWidth(24)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.wb_sunny_outlined,
                                    size: 20.0,
                                    color: ColorsHelpers.pinkAccent,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(8)),
                                    child: widgetText('GOOD MORNING',
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: ColorsHelpers.pinkAccent),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(5)),
                                child: widgetText('Madelyn Dias',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Colors.white),
                              )
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingScreen()));
                              },
                              child: SvgPicture.asset(Images.avatar))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(24),
                          right: ScreenUtil().setWidth(24),
                          top: ScreenUtil().setHeight(24)),
                      height: ScreenUtil().setHeight(84),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromRGBO(255, 204, 213, 1),
                      ),
                      child: Stack(
                        children: [
                          SvgPicture.asset(Images.curveLine,
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill),
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(24),
                                top: ScreenUtil().setHeight(16)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widgetText('RECENT QUIZ',
                                        color: ColorsHelpers.redBlood
                                            .withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(14),
                                        letterSpacing: 4),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(8),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Images.headphone,
                                          height: 24,
                                          width: 24,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(8),
                                          ),
                                          child: widgetText(
                                              'A Basic Music Quiz',
                                              fontSize: ScreenUtil().setSp(18),
                                              fontWeight: FontWeight.w500,
                                              color: ColorsHelpers.redBlood),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(28)),
                                  child: CircularPercentIndicator(
                                    radius: 28.0,
                                    lineWidth: 28.0,
                                    percent: 0.65,
                                    animation: true,
                                    center: widgetText('65%',
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(14),
                                        color: Colors.white),
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: ColorsHelpers.pink2,
                                    progressColor: ColorsHelpers.pink,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(232),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(24),
                          left: ScreenUtil().setWidth(24),
                          right: ScreenUtil().setWidth(24)),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(143, 136, 228, 1)),
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20)),
                                child: SvgPicture.asset(
                                  Images.ovalWithOutlineBottomHomeScreen,
                                  width: 160,
                                  height: 160,
                                ),
                              )),
                          Positioned(
                              right: 1,
                              top: 0,
                              child: RotationTransition(
                                turns: const AlwaysStoppedAnimation(180 / 360),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20)),
                                  child: SvgPicture.asset(
                                    Images.ovalWithOutlineBottomHomeScreen,
                                    width: 160,
                                    height: 160,
                                  ),
                                ),
                              )),
                          Positioned(
                              left: 16,
                              top: 16,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20)),
                                child: SvgPicture.asset(
                                  Images.person,
                                  height: ScreenUtil().setHeight(48),
                                  width: ScreenUtil().setWidth(48),
                                ),
                              )),
                          Positioned(
                              right: ScreenUtil().setWidth(15),
                              bottom: ScreenUtil().setHeight(42),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20)),
                                child: SvgPicture.asset(
                                  Images.personTwo,
                                  height: ScreenUtil().setHeight(56),
                                  width: ScreenUtil().setWidth(64),
                                ),
                              )),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(40)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(16)),
                                    child: widgetText('FEATURED',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: ScreenUtil().setSp(14),
                                        letterSpacing: 5),
                                  ),
                                  Container(
                                    child: widgetText(
                                        'Take part in challenges\nwith friends or other\nplayers',
                                        fontWeight: FontWeight.w500,
                                        align: TextAlign.center,
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(18)),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(44),
                                    width: ScreenUtil().setWidth(146),
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16)),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          backgroundColor: Colors.white),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: SvgPicture.asset(
                                              Images.buttonIcon,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: widgetText("Find Friends",
                                                  color: ColorsHelpers
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      ScreenUtil().setSp(14))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                      padding: const EdgeInsets.all(24),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(32),
                              topLeft: Radius.circular(32))),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widgetText('Live Quizzes',
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(20),
                                color: Colors.black),
                            widgetText('See all',
                                color: ColorsHelpers.primaryColor,
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(16)),
                          child: listItem(SvgPicture.asset(Images.chart),
                              'Statistics Math Quiz', 'Math • 12 Quizzes', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailQuizScreen()));
                          }, Colors.white, Colors.black, ColorsHelpers.grey2),
                        ),
                        listItem(SvgPicture.asset(Images.integers),
                            'Integers Quiz', 'Math • 10 Quizzes', () {
                          requestCameraPermission();
                        }, Colors.white, Colors.black, ColorsHelpers.grey2),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
