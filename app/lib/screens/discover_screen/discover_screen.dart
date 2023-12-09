import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  bool isClick = false;
  bool isChanged = false;
  TabController? _tabController;
  final int _leaderboarInit = 2;
  late FocusNode myFocusNode;

  final _leaderboards = const [
    {
      'number': '1',
      'avatar': Images.leaderboardAvatar1,
      'flag': Images.flagPortugal,
      'name': 'Davis Curtis',
      'point': '2,569',
      'medal': Images.medalGold
    },
    {
      'number': '2',
      'avatar': Images.leaderboardAvatar2,
      'flag': Images.flagFrance,
      'name': 'Alena Donin',
      'point': '1,469',
      'medal': Images.medalSilver
    },
    {
      'number': '3',
      'avatar': Images.leaderboardAvatar3,
      'flag': Images.flagCanada,
      'name': 'Craig Gouse',
      'point': '1,053',
      'medal': Images.medalBronze
    },
    {
      'number': '4',
      'avatar': Images.leaderboardAvatar4,
      'flag': Images.flagHungary,
      'name': 'Madelyn Dias',
      'point': '590',
      'medal': null
    },
    {
      'number': '5',
      'avatar': Images.leaderboardAvatar5,
      'flag': Images.flagItaly,
      'name': 'Zain Vaccaro',
      'point': '448',
      'medal': null
    },
    {
      'number': '6',
      'avatar': Images.leaderboardAvatar6,
      'flag': Images.flagCzech,
      'name': 'Skylar Geidt',
      'point': '448',
      'medal': null
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    myFocusNode = FocusNode();

    KeyboardVisibilityController().onChange.listen((isVisible) {
      if (isVisible) {
        isClick = true;
      } else {
        isClick = false;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsHelpers.primaryColor,
        elevation: 0,
        title: widgetText('Discover', color: Colors.white),
      ),
      body: Container(
        color: ColorsHelpers.primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        ///scroll widget
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(112),
                  right: ScreenUtil().setWidth(24),
                  left: ScreenUtil().setHeight(24),
                ),

                /// search textformfield
                child: TextFormField(
                  focusNode: myFocusNode,
                  onTap: () {
                    setState(() {
                      isClick = true;
                    });
                  },
                  onChanged: (text) {
                    if (text != '') {
                      setState(() {
                        isChanged = true;
                      });
                    } else {
                      setState(() {
                        isChanged = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0)),
                    fillColor: ColorsHelpers.neutralOpacity0_2,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.yellow),
                    focusColor: Colors.white,
                    hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    contentPadding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(19),
                    ),
                    hintText: !isClick ? 'Quiz, categories, or friends' : '',
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
              ),
              !isClick
                  ? Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: ScreenUtil().setHeight(163),
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                              left: ScreenUtil().setWidth(24),
                              right: ScreenUtil().setWidth(24)),
                          decoration: BoxDecoration(
                              color: ColorsHelpers.peach,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20)),
                                    child: SvgPicture.asset(Images.personThree,
                                        fit: BoxFit.fitWidth)),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 36,
                                child: Container(
                                  child: widgetText(
                                    'Travel Trivia Quiz',
                                    fontWeight: FontWeight.w500,
                                    color: ColorsHelpers.redBlood,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 17,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      Images.travelIcon,
                                      color: ColorsHelpers.redBlood,
                                      height: 16,
                                      width: 16,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      child: widgetText('Music • 5 Quizzes',
                                          fontWeight: FontWeight.w400,
                                          color: ColorsHelpers.redBlood,
                                          fontSize: ScreenUtil().setSp(12)),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 20,
                                  top: 16,
                                  child: widgetButton(
                                      widgetText(
                                        'TOP PICKS',
                                        fontWeight: FontWeight.w500,
                                        align: TextAlign.center,
                                        fontSize: ScreenUtil().setSp(11),
                                      ),
                                      color: ColorsHelpers.pink,
                                      width: ScreenUtil().setWidth(89.0),
                                      height: ScreenUtil().setHeight(30.0),
                                      radius: 8.0,
                                      () {}))
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.5,
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(24),
                              right: ScreenUtil().setWidth(24),
                              top: ScreenUtil().setHeight(24)),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(32),
                                  topLeft: Radius.circular(32))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: widgetText('Top rank of the week',
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: ScreenUtil().setHeight(92),
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16)),
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image:
                                                AssetImage(Images.curveLine2),
                                            fit: BoxFit.fitHeight,
                                            alignment: Alignment.bottomRight),
                                        color: ColorsHelpers.primaryColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: Container(
                                            height: 24,
                                            width: 24,
                                            margin: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setWidth(20)),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            child: widgetText('1',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    ScreenUtil().setWidth(4)),
                                                child: SvgPicture.asset(
                                                    Images.avatar2),
                                              ),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight:
                                                      ScreenUtil().setWidth(20),
                                                  maxWidth:
                                                      ScreenUtil().setWidth(20),
                                                ),
                                                child: Image.asset(
                                                    Images.flagCzech),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setWidth(20)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setHeight(4)),
                                                  child: widgetText(
                                                      'Brandon Matrovs',
                                                      fontSize: ScreenUtil()
                                                          .setSp(16),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                                widgetText('124 points',
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      right: 16,
                                      child: SvgPicture.asset(Images.medalGold))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(24),
                                    bottom: ScreenUtil().setHeight(16)),
                                child: widgetText('Categories',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(20),
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.tosca,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: ColorsHelpers
                                                      .whiteOpacity0_2,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.mathIcon,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              'Math',
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            ' 21 Quizzies',
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.dullLavender,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: ColorsHelpers
                                                      .whiteOpacity0_2,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.scienceIcon,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              'Science',
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            ' 12 Quizzies',
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(8),
                            right: ScreenUtil().setWidth(8),
                            top: ScreenUtil().setHeight(24)),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1.1,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(32)),
                            color: ColorsHelpers.grey5),
                        child: Column(children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(10),
                                  bottom: ScreenUtil().setHeight(4),
                                ),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setSp(20)),
                                    color: ColorsHelpers.grey5),
                              ),
                              Transform.translate(
                                offset:
                                    Offset(0, ScreenUtil().setHeight(-10.5)),
                                child: SvgPicture.asset(
                                    Images.leaderboardWhiteContainer),
                              ),
                              Transform.translate(
                                offset: Offset(0, ScreenUtil().setHeight(-4)),
                                child: Container(
                                  width: ScreenUtil().setWidth(8),
                                  height: ScreenUtil().setHeight(8),
                                  decoration: BoxDecoration(
                                    color: ColorsHelpers.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TabBar(
                            controller: _tabController,
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
                                text: 'Top',
                              ),
                              Tab(
                                text: 'Quiz',
                              ),
                              Tab(
                                text: 'Categories',
                              ),
                              Tab(
                                text: 'Friends',
                              ),
                            ],
                            onTap: (l) {},
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(24),
                                          left: ScreenUtil().setWidth(16),
                                          right: ScreenUtil().setWidth(16)),
                                      child: !isChanged
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    widgetText(
                                                        'Recent Searches',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        color: Colors.black),
                                                    widgetText('Clear all',
                                                        color: ColorsHelpers
                                                            .primaryColor,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        fontWeight:
                                                            FontWeight.w500)
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(16),
                                                      bottom: ScreenUtil()
                                                          .setHeight(16)),
                                                  child: listItem(
                                                      SvgPicture.asset(
                                                          Images.chart),
                                                      'Statistics Math Quiz',
                                                      'Math • 12 Quizzes',
                                                      () {},
                                                      Colors.white,
                                                      Colors.black,
                                                      ColorsHelpers.grey2),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2,
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(16)),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Wrap(
                                                      children: _leaderboards
                                                          .getRange(
                                                              _leaderboarInit,
                                                              _leaderboards
                                                                  .length)
                                                          .map(
                                                            (e) => Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                // top: ScreenUtil().setHeight(10),
                                                                right:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                bottom:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            16),
                                                              ),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Row(
                                                                children: [
                                                                  Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                          e['avatar']
                                                                              .toString()),
                                                                      ConstrainedBox(
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          maxHeight:
                                                                              ScreenUtil().setWidth(20),
                                                                          maxWidth:
                                                                              ScreenUtil().setWidth(20),
                                                                        ),
                                                                        child: Image.asset(
                                                                            e['flag'].toString()),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              ScreenUtil().setWidth(16)),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          widgetText(
                                                                            e['name'].toString(),
                                                                            fontSize:
                                                                                ScreenUtil().setSp(16),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                          widgetText(
                                                                            '${e["point"]} points',
                                                                            fontSize:
                                                                                ScreenUtil().setSp(14),
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                ColorsHelpers.grey2,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    widgetText('Quiz',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        color: Colors.black),
                                                    widgetText('See all',
                                                        color: ColorsHelpers
                                                            .primaryColor,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        fontWeight:
                                                            FontWeight.w500)
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(16),
                                                      bottom: ScreenUtil()
                                                          .setHeight(16)),
                                                  child: listItem(
                                                      SvgPicture.asset(
                                                          Images.chart),
                                                      'Statistics Math Quiz',
                                                      'Math • 12 Quizzes',
                                                      () {},
                                                      Colors.white,
                                                      Colors.black,
                                                      ColorsHelpers.grey2),
                                                ),
                                                listItem(
                                                    SvgPicture.asset(
                                                        Images.integers),
                                                    'Integers Quiz',
                                                    'Math • 10 Quizzes',
                                                    () {},
                                                    Colors.white,
                                                    Colors.black,
                                                    ColorsHelpers.grey2),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(24),
                                                      bottom: ScreenUtil()
                                                          .setHeight(16)),
                                                  child: widgetText('Friends',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: ScreenUtil()
                                                          .setSp(20),
                                                      color: Colors.black),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2,
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(16)),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Wrap(
                                                      children: _leaderboards
                                                          .getRange(
                                                              _leaderboarInit,
                                                              _leaderboards
                                                                  .length)
                                                          .map(
                                                            (e) => Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                // top: ScreenUtil().setHeight(10),
                                                                right:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                bottom:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            16),
                                                              ),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Row(
                                                                children: [
                                                                  Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                          e['avatar']
                                                                              .toString()),
                                                                      ConstrainedBox(
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          maxHeight:
                                                                              ScreenUtil().setWidth(20),
                                                                          maxWidth:
                                                                              ScreenUtil().setWidth(20),
                                                                        ),
                                                                        child: Image.asset(
                                                                            e['flag'].toString()),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              ScreenUtil().setWidth(16)),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          widgetText(
                                                                            e['name'].toString(),
                                                                            fontSize:
                                                                                ScreenUtil().setSp(16),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                          widgetText(
                                                                            '${e["point"]} points',
                                                                            fontSize:
                                                                                ScreenUtil().setSp(14),
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                ColorsHelpers.grey2,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(24),
                                        left: ScreenUtil().setWidth(16),
                                        right: ScreenUtil().setWidth(16)),
                                    child: Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(16),
                                            bottom: ScreenUtil().setHeight(16)),
                                        child: listItem(
                                            SvgPicture.asset(Images.chart),
                                            'Statistics Math Quiz',
                                            'Math • 12 Quizzes',
                                            () {},
                                            Colors.white,
                                            Colors.black,
                                            ColorsHelpers.grey2),
                                      ),
                                      listItem(
                                          SvgPicture.asset(Images.integers),
                                          'Integers Quiz',
                                          'Math • 10 Quizzes',
                                          () {},
                                          Colors.white,
                                          Colors.black,
                                          ColorsHelpers.grey2),
                                    ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(24),
                                        left: ScreenUtil().setWidth(16),
                                        right: ScreenUtil().setWidth(16)),
                                    child: Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(16),
                                            bottom: ScreenUtil().setHeight(16)),
                                        child: listItem(
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: ColorsHelpers
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.mathIcon,
                                                color: Colors.white,
                                              ),
                                            ),
                                            'Math Quiz',
                                            'Math • 12 Quizzes',
                                            () {},
                                            Colors.white,
                                            Colors.black,
                                            ColorsHelpers.grey2),
                                      ),
                                      listItem(
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            padding: EdgeInsets.all(
                                                ScreenUtil().setWidth(9)),
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorsHelpers.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil()
                                                            .setSp(16))),
                                            child: SvgPicture.asset(
                                              Images.scienceIcon,
                                              color: Colors.white,
                                            ),
                                          ),
                                          'Science',
                                          'Science • 10 Quizzes',
                                          () {},
                                          Colors.white,
                                          Colors.black,
                                          ColorsHelpers.grey2),
                                    ]),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16)),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Wrap(
                                        children: _leaderboards
                                            .getRange(_leaderboarInit,
                                                _leaderboards.length)
                                            .map(
                                              (e) => Container(
                                                margin: EdgeInsets.only(
                                                  // top: ScreenUtil().setHeight(10),
                                                  right:
                                                      ScreenUtil().setWidth(16),
                                                ),
                                                padding: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(16),
                                                  right:
                                                      ScreenUtil().setWidth(16),
                                                  bottom: ScreenUtil()
                                                      .setHeight(16),
                                                ),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      children: [
                                                        SvgPicture.asset(
                                                            e['avatar']
                                                                .toString()),
                                                        ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxHeight:
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        20),
                                                            maxWidth:
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        20),
                                                          ),
                                                          child: Image.asset(
                                                              e['flag']
                                                                  .toString()),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: ScreenUtil()
                                                                .setWidth(16)),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            widgetText(
                                                              e['name']
                                                                  .toString(),
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          16),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            widgetText(
                                                              '${e["point"]} points',
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  ColorsHelpers
                                                                      .grey2,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ]),
                          )
                        ]),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter? _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter!;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration? cfg) {
    final Offset circleOffset =
        offset + Offset(cfg!.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
