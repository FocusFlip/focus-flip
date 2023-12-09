import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quezzy/screens/setting_screen/setting_screen.dart';
import 'package:quezzy/utils/chart_series.dart';
import 'package:quezzy/utils/chart_widget.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../discover_screen/discover_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  int? _selectedItem = 0;
  final List<String> items = [
    'Daily',
    'Monthly',
    'Weekly',
    'Yearly',
  ];
  String? selectedValue;
  final badgeList = <String>[
    Images.badge1,
    Images.badge1,
    Images.badge1,
  ];
  final nbs = <int>[3, 4, 3];

  final List<ChartSeries> data = [
    ChartSeries(
      year: '3/10\nQuistions\nAnswered',
      developers: 20,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromRGBO(255, 214, 221, 1)),
    ),
    ChartSeries(
      year: '8/10\nQuistions\nAnswered',
      developers: 80,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromRGBO(196, 208, 251, 1)),
    ),
    ChartSeries(
      year: '6/10\nQuistions\nAnswered',
      developers: 60,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromRGBO(169, 173, 243, 1)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller!.addListener(() {
      setState(() {
        _selectedItem = _controller!.index;
      });
    });

    _controller!.index = _selectedItem!;
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(
            color: Colors.white,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
              child: Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          color: ColorsHelpers.primaryColor,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -50,
                child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(120 / 360),
                    child: Image.asset(
                      Images.ovalTwoBig,
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                    )),
              ),
              Positioned(
                left: -50,
                top: 100,
                child: Image.asset(
                  Images.ovalTwoBig,
                  height: ScreenUtil().setHeight(200),
                  width: ScreenUtil().setWidth(200),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(50),
                          left: ScreenUtil().setWidth(8),
                          right: ScreenUtil().setWidth(8)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(48),
                                bottom: ScreenUtil().setHeight(24)),
                            child: widgetText('Madelyn Dias',
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.black),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: ScreenUtil().setHeight(101),
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(16),
                                right: ScreenUtil().setWidth(16)),
                            decoration: BoxDecoration(
                                color: ColorsHelpers.primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star_border,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: widgetText('POINTS',
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(12),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            letterSpacing: 2),
                                      ),
                                      widgetText('590',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(16))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 69,
                                  width: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.1, 0.5, 0.9],
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0.5),
                                        Colors.white.withOpacity(0.1),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Images.globe,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: widgetText('WORLD RANK',
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(12),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            letterSpacing: 1),
                                      ),
                                      widgetText('#1,590',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(16))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 69,
                                  width: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.1, 0.5, 0.9],
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0.5),
                                        Colors.white.withOpacity(0.1),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Images.rank,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: widgetText('LOCAL RANK',
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(12),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            letterSpacing: 1),
                                      ),
                                      widgetText('#56',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(16))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(16),
                            ),
                            child: TabBar(
                              controller: _controller,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: CircleTabIndicator(
                                  color: ColorsHelpers.primaryColor, radius: 4),
                              labelStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w700),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400),
                              labelColor: ColorsHelpers.primaryColor,
                              unselectedLabelColor: ColorsHelpers.grey2,
                              labelPadding: EdgeInsets.zero,
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(15),
                                  right: ScreenUtil().setWidth(15)),
                              tabs: const [
                                Tab(
                                  text: 'Badge',
                                ),
                                Tab(
                                  text: 'Stat',
                                ),
                                Tab(
                                  text: 'Details',
                                ),
                              ],
                              onTap: (l) {},
                            ),
                          ),
                          Expanded(
                            child:
                                TabBarView(controller: _controller, children: [
                              SingleChildScrollView(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(24),
                                      right: ScreenUtil().setWidth(24),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: const ShapeDecoration(
                                                shape: PolygonBorder(
                                                  sides: 6,
                                                  rotate: 0,
                                                  side: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Image.asset(
                                                Images.badge1,
                                                height:
                                                    ScreenUtil().setHeight(88),
                                                width:
                                                    ScreenUtil().setWidth(88),
                                              ),
                                            ),
                                            Container(
                                              decoration: const ShapeDecoration(
                                                shape: PolygonBorder(
                                                  sides: 6,
                                                  rotate: 0,
                                                  side: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Image.asset(
                                                Images.badge3,
                                                height:
                                                    ScreenUtil().setHeight(88),
                                                width:
                                                    ScreenUtil().setWidth(88),
                                              ),
                                            ),
                                            Container(
                                              decoration: const ShapeDecoration(
                                                shape: PolygonBorder(
                                                  sides: 6,
                                                  rotate: 0,
                                                  side: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Image.asset(
                                                Images.badge2,
                                                height:
                                                    ScreenUtil().setHeight(88),
                                                width:
                                                    ScreenUtil().setWidth(88),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(12),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: const ShapeDecoration(
                                                shape: PolygonBorder(
                                                  sides: 6,
                                                  rotate: 0,
                                                  side: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Image.asset(
                                                Images.badge4,
                                                height:
                                                    ScreenUtil().setHeight(88),
                                                width:
                                                    ScreenUtil().setWidth(88),
                                              ),
                                            ),
                                            Container(
                                              decoration: const ShapeDecoration(
                                                shape: PolygonBorder(
                                                  sides: 6,
                                                  rotate: 0,
                                                  side: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Image.asset(
                                                Images.badge5,
                                                height:
                                                    ScreenUtil().setHeight(88),
                                                width:
                                                    ScreenUtil().setWidth(88),
                                              ),
                                            ),
                                            Container(
                                              decoration: const ShapeDecoration(
                                                shape: PolygonBorder(
                                                  sides: 6,
                                                  rotate: 0,
                                                  side: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Image.asset(
                                                Images.badge6,
                                                height:
                                                    ScreenUtil().setHeight(88),
                                                width:
                                                    ScreenUtil().setWidth(88),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.3,
                                      margin: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(16),
                                          left: ScreenUtil().setWidth(16),
                                          right: ScreenUtil().setWidth(16)),
                                      padding: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(16),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: ColorsHelpers.thirdLavender),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: SvgPicture.asset(
                                                  Images.curveLine3)),
                                          Positioned(
                                            right: 0,
                                            top: 16,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                icon: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(12)),
                                                  child: Visibility(
                                                    visible: true,
                                                    child: SvgPicture.asset(
                                                      Images.arrowBottom,
                                                      width: ScreenUtil()
                                                          .setSp(16),
                                                      height: ScreenUtil()
                                                          .setSp(16),
                                                    ),
                                                  ),
                                                ),
                                                hint: widgetText('Montly',
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                                items: items
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e,
                                                        child: widgetText(
                                                          e,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                value: selectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedValue =
                                                        value as String;
                                                  });
                                                },
                                                buttonDecoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          ColorsHelpers.grey5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(12)),
                                                ),
                                                buttonHeight:
                                                    ScreenUtil().setHeight(34),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top:
                                                    ScreenUtil().setHeight(74)),
                                            child: Column(
                                              children: [
                                                RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "You have played a total\n",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Rubik",
                                                              color: Colors
                                                                  .black)),
                                                      TextSpan(
                                                        text: '24 Quizzes ',
                                                        style: TextStyle(
                                                            fontFamily: "Rubik",
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(20),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorsHelpers
                                                                .primaryColor),
                                                      ),
                                                      TextSpan(
                                                          text: 'this month! ',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              fontFamily:
                                                                  "Rubik",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(16),
                                                ),
                                                CircularPercentIndicator(
                                                  radius: 120.0,
                                                  lineWidth: 18.0,
                                                  animation: true,
                                                  percent: 0.7,
                                                  center: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: "37",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            32),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    "Rubik",
                                                                color: Colors
                                                                    .black)),
                                                        TextSpan(
                                                          text: '/ 50\n',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Rubik",
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  24,
                                                                  18,
                                                                  84,
                                                                  0.3)),
                                                        ),
                                                        TextSpan(
                                                            text: 'quiz played',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            20),
                                                                fontFamily:
                                                                    "Rubik",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    24,
                                                                    18,
                                                                    84,
                                                                    0.3))),
                                                      ],
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: ColorsHelpers
                                                      .primaryColor,
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(24),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: ScreenUtil()
                                                          .setWidth(130),
                                                      height: ScreenUtil()
                                                          .setHeight(96),
                                                      margin: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(16)),
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          color: Colors.white),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                right:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                bottom: ScreenUtil()
                                                                    .setHeight(
                                                                        16)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: ScreenUtil()
                                                                          .setHeight(
                                                                              16)),
                                                                  child: widgetText(
                                                                      '5',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize: ScreenUtil()
                                                                          .setSp(
                                                                              32),
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                SvgPicture.asset(
                                                                    Images
                                                                        .pencil,
                                                                    height: 24,
                                                                    width: 24,
                                                                    color: Colors
                                                                        .black),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16)),
                                                            child: widgetText(
                                                                'Quiz Created',
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: ScreenUtil()
                                                          .setWidth(130),
                                                      height: ScreenUtil()
                                                          .setHeight(96),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          color: ColorsHelpers
                                                              .primaryColor),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                right:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                bottom: ScreenUtil()
                                                                    .setHeight(
                                                                        16)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: ScreenUtil()
                                                                          .setHeight(
                                                                              16)),
                                                                  child: widgetText(
                                                                      '21',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize: ScreenUtil()
                                                                          .setSp(
                                                                              32),
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                SvgPicture.asset(
                                                                    Images
                                                                        .starIcon,
                                                                    height: 24,
                                                                    width: 24,
                                                                    color: Colors
                                                                        .white),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16)),
                                                            child: widgetText(
                                                                'Quiz Won',
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      margin: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(16),
                                          left: ScreenUtil().setWidth(16),
                                          right: ScreenUtil().setWidth(16)),
                                      padding: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(16),
                                          left: ScreenUtil().setWidth(16),
                                          top: ScreenUtil().setHeight(24)),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: ColorsHelpers.primaryColor),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: widgetText(
                                                  'Top performance by\ncategory',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      ScreenUtil().setSp(20),
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  color: Colors.white
                                                      .withOpacity(0.2)),
                                              child: const Icon(
                                                Icons.bar_chart,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(16),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: ScreenUtil()
                                                      .setWidth(32)),
                                              child: Row(children: [
                                                Container(
                                                  height: 8,
                                                  width: 8,
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(8)),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255, 214, 221, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50))),
                                                ),
                                                widgetText('Math',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil().setSp(14))
                                              ]),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: ScreenUtil()
                                                      .setWidth(32)),
                                              child: Row(children: [
                                                Container(
                                                  height: 8,
                                                  width: 8,
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(8)),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              196, 208, 251, 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50))),
                                                ),
                                                widgetText('Sports',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil().setSp(14))
                                              ]),
                                            ),
                                            Row(children: [
                                              Container(
                                                height: 8,
                                                width: 8,
                                                margin: EdgeInsets.only(
                                                    right: ScreenUtil()
                                                        .setWidth(8)),
                                                decoration: const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        169, 173, 243, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                              ),
                                              widgetText('Music',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize:
                                                      ScreenUtil().setSp(14))
                                            ]),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(24)),
                                          height: 300,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: DeveloperChart(
                                            data: data,
                                          ),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(150),
                                      left: ScreenUtil().setWidth(16),
                                      right: ScreenUtil().setWidth(16)),
                                  padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(16),
                                    left: ScreenUtil().setWidth(16),
                                    right: ScreenUtil().setWidth(16),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: ColorsHelpers.thirdLavender),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            widgetText('Recent matches',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(20),
                                                color: Colors.black),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                icon: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(12)),
                                                  child: Visibility(
                                                    visible: true,
                                                    child: SvgPicture.asset(
                                                      Images.arrowBottom,
                                                      width: ScreenUtil()
                                                          .setSp(16),
                                                      height: ScreenUtil()
                                                          .setSp(16),
                                                    ),
                                                  ),
                                                ),
                                                hint: widgetText('Montly',
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                                items: items
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e,
                                                        child: widgetText(
                                                          e,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                value: selectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedValue =
                                                        value as String;
                                                  });
                                                },
                                                buttonDecoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          ColorsHelpers.grey5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(12)),
                                                ),
                                                buttonHeight:
                                                    ScreenUtil().setHeight(34),
                                              ),
                                            )
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(16)),
                                                    padding: EdgeInsets.all(
                                                        ScreenUtil()
                                                            .setWidth(4)),
                                                    child: SvgPicture.asset(
                                                        height: 60,
                                                        width: 60,
                                                        Images.avatar),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxHeight: ScreenUtil()
                                                          .setWidth(20),
                                                      maxWidth: ScreenUtil()
                                                          .setWidth(20),
                                                    ),
                                                    child: Image.asset(
                                                        Images.flagHungary),
                                                  ),
                                                ],
                                              ),
                                              SvgPicture.asset(
                                                  Images.medalGold),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top:
                                                    ScreenUtil().setHeight(15)),
                                            child: widgetText('VS',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(20)),
                                          ),
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(16)),
                                                    padding: EdgeInsets.all(
                                                        ScreenUtil()
                                                            .setWidth(4)),
                                                    child: SvgPicture.asset(
                                                        height: 60,
                                                        width: 60,
                                                        Images
                                                            .leaderboardAvatar2),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxHeight: ScreenUtil()
                                                          .setWidth(20),
                                                      maxWidth: ScreenUtil()
                                                          .setWidth(20),
                                                    ),
                                                    child: Image.asset(
                                                        Images.flagPortugal),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(72),
                                            height: ScreenUtil().setHeight(34),
                                            margin: EdgeInsets.only(
                                                top:
                                                    ScreenUtil().setHeight(15)),
                                            decoration: BoxDecoration(
                                                color: ColorsHelpers.tosca,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8))),
                                            alignment: Alignment.center,
                                            child: widgetText('+100 QP',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(20),
                                            bottom: ScreenUtil().setHeight(20)),
                                        color: ColorsHelpers.fourthLavender,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(16)),
                                                    padding: EdgeInsets.all(
                                                        ScreenUtil()
                                                            .setWidth(4)),
                                                    child: SvgPicture.asset(
                                                        height: 60,
                                                        width: 60,
                                                        Images.avatar),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxHeight: ScreenUtil()
                                                          .setWidth(20),
                                                      maxWidth: ScreenUtil()
                                                          .setWidth(20),
                                                    ),
                                                    child: Image.asset(
                                                        Images.flagHungary),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top:
                                                    ScreenUtil().setHeight(15)),
                                            child: widgetText('VS',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(20)),
                                          ),
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(16)),
                                                    padding: EdgeInsets.all(
                                                        ScreenUtil()
                                                            .setWidth(4)),
                                                    child: SvgPicture.asset(
                                                        height: 60,
                                                        width: 60,
                                                        Images
                                                            .leaderboardAvatar3),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxHeight: ScreenUtil()
                                                          .setWidth(20),
                                                      maxWidth: ScreenUtil()
                                                          .setWidth(20),
                                                    ),
                                                    child: Image.asset(
                                                        Images.flagCanada),
                                                  ),
                                                ],
                                              ),
                                              SvgPicture.asset(
                                                  Images.medalGold),
                                            ],
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(72),
                                            height: ScreenUtil().setHeight(34),
                                            margin: EdgeInsets.only(
                                                top:
                                                    ScreenUtil().setHeight(15)),
                                            decoration: BoxDecoration(
                                                color: ColorsHelpers.red,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8))),
                                            alignment: Alignment.center,
                                            child: widgetText('-50 QP',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              Images.avatar,
                              width: 96,
                              height: 96,
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Image.asset(
                                  Images.flag,
                                  width: 28,
                                  height: 28,
                                ))
                          ],
                        ))
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
