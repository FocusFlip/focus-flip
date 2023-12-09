import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';
import 'package:quezzy/utils/widget_assets.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => LeaderboardScreenState();
}

class LeaderboardScreenState extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  AnimationController? _controller;
  Animation<double>? _heightFactorAnimation;
  double _collapsedHeightInit = 160.0;
  double _translateOvalInit = 80.0;
  bool isAnimationCompleted = false;
  bool _orangeAlert = true;
  bool _isWeekly = true;
  bool _isCollapsed = true;
  bool isScrollDown = false;
  double screenHeight = 0;
  int _leaderboarInit = 3;

  ScrollController scrollController = ScrollController();

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
    _tabController = TabController(length: 2, vsync: this);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _initTween();

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  _initTween() {
    _heightFactorAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
                  begin: _collapsedHeightInit, end: screenHeight * 0.75)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
      ],
    ).animate(_controller!);
  }

  _handleTabTapped(value) {
    setState(() {
      if (value == 0) {
        _isWeekly = true;
        _collapsedHeightInit = 160.0;
        if (_isCollapsed) {
          _orangeAlert = true;
        }
        _translateOvalInit = 80.0;
      } else {
        _isWeekly = false;
        _orangeAlert = false;
        _collapsedHeightInit = 265.0;
        if (_isCollapsed) {
          _translateOvalInit = -18.0;
        }
      }
      _initTween();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsHelpers.primaryColor,
        elevation: 0,
        title: widgetText(
          'Leaderboard',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(24),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(24.0)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(24)),
            child: const BackButton(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        height: double.infinity,
        color: ColorsHelpers.primaryColor,
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, ScreenUtil().setHeight(_translateOvalInit)),
              child: Center(
                child:
                    SvgPicture.asset(Images.leaderboardOval, fit: BoxFit.fill),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(24),
                    right: ScreenUtil().setWidth(24),
                    top: ScreenUtil().setHeight(16),
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(20)),
                      color: ColorsHelpers.neutralOpacity0_3),
                  padding: EdgeInsets.all(ScreenUtil().setSp(4)),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(16)),
                      color: ColorsHelpers.dullLavender,
                    ),
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w700),
                    unselectedLabelStyle: TextStyle(
                        color: ColorsHelpers.grey4Opacity0_7,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400),
                    tabs: const [
                      Tab(
                        text: 'Weekly',
                      ),
                      Tab(
                        text: 'All Time',
                      ),
                    ],
                    onTap: _handleTabTapped,
                  ),
                ),
                Visibility(
                  visible: _orangeAlert,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(24),
                      right: ScreenUtil().setWidth(24),
                      top: ScreenUtil().setHeight(16),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(20)),
                        color: ColorsHelpers.orange),
                    padding: EdgeInsets.all(ScreenUtil().setSp(4)),
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                      child: Row(
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(56),
                            height: ScreenUtil().setWidth(56),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(20)),
                                color: ColorsHelpers.orangeSecond),
                            child: widgetText(
                              "#4",
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(16)),
                              child: widgetText(
                                'You are doing better than 60% of other players!',
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(24),
                        vertical: ScreenUtil().setHeight(20),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setWidth(4)),
                                    child: SvgPicture.asset(
                                        Images.leaderboardAvatar2),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: ScreenUtil().setWidth(20),
                                      maxWidth: ScreenUtil().setWidth(20),
                                    ),
                                    child: Image.asset(Images.flagFrance),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(16),
                                  bottom: ScreenUtil().setHeight(4),
                                ),
                                child: widgetText(
                                  'Alena Donin',
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setSp(20)),
                                    color: ColorsHelpers.dullLavender),
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(12),
                                  vertical: ScreenUtil().setHeight(8),
                                ),
                                child: widgetText(
                                  '1,469 QP',
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(8)),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        (MediaQuery.of(context).size.width -
                                                ScreenUtil().setWidth(48)) /
                                            3,
                                  ),
                                  child: Image.asset(Images.rank2),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(16)),
                                        padding: EdgeInsets.all(
                                            ScreenUtil().setWidth(4)),
                                        child: SvgPicture.asset(
                                            Images.leaderboardAvatar1),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: ScreenUtil().setWidth(20),
                                          maxWidth: ScreenUtil().setWidth(20),
                                        ),
                                        child: Image.asset(Images.flagPortugal),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setHeight(4)),
                                    child: SvgPicture.asset(Images.medalGold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(16),
                                  bottom: ScreenUtil().setHeight(4),
                                ),
                                child: widgetText(
                                  'Davis Curtis',
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setSp(20)),
                                    color: ColorsHelpers.dullLavender),
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(12),
                                  vertical: ScreenUtil().setHeight(8),
                                ),
                                child: widgetText(
                                  '2,569 QP',
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(8)),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        (MediaQuery.of(context).size.width -
                                                ScreenUtil().setWidth(48)) /
                                            3,
                                  ),
                                  child: Image.asset(Images.rank1),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(64)),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setWidth(4)),
                                      child: SvgPicture.asset(
                                          Images.leaderboardAvatar3),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: ScreenUtil().setWidth(20),
                                        maxWidth: ScreenUtil().setWidth(20),
                                      ),
                                      child: Image.asset(Images.flagCanada),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(16),
                                    bottom: ScreenUtil().setHeight(4),
                                  ),
                                  child: widgetText(
                                    'Craig Gouse',
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setSp(20)),
                                      color: ColorsHelpers.dullLavender),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(12),
                                    vertical: ScreenUtil().setHeight(8),
                                  ),
                                  child: widgetText(
                                    '1,053 QP',
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(8)),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          (MediaQuery.of(context).size.width -
                                                  ScreenUtil().setWidth(48)) /
                                              3,
                                    ),
                                    child: Image.asset(Images.rank3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isWeekly && _isCollapsed,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(16),
                            right: ScreenUtil().setWidth(24),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(20)),
                              color: ColorsHelpers.neutralOpacity0_3),
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(8),
                            horizontal: ScreenUtil().setWidth(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: ScreenUtil().setWidth(16),
                                  maxHeight: ScreenUtil().setWidth(16),
                                ),
                                child: SvgPicture.asset(Images.clockIcon),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(6)),
                                child: widgetText(
                                  '06d 23h 00m',
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w500,
                                  color: ColorsHelpers.grey4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: _controller!,
                builder: (context, child) => Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(8),
                    right: ScreenUtil().setWidth(8),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: _heightFactorAnimation!.value,
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
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(20)),
                              color: ColorsHelpers.grey5),
                        ),
                        Transform.translate(
                          offset: Offset(0, ScreenUtil().setHeight(-10.5)),
                          child: SvgPicture.asset(
                              Images.leaderboardWhiteContainer),
                        ),
                        Transform.translate(
                          offset: Offset(0, ScreenUtil().setHeight(-4)),
                          child: Container(
                            width: ScreenUtil().setWidth(8),
                            height: ScreenUtil().setHeight(8),
                            decoration: BoxDecoration(
                              color: ColorsHelpers.secondLavender,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GestureDetector(
                        // onVerticalDragStart: _handleDraggedContainer,
                        // onVerticalDragDown: _handleDraggedDownContainer,
                        child: NotificationListener(
                          onNotification: (t) {
                            if (t is ScrollEndNotification) {
                              if (scrollController.position.pixels.round() <
                                  0) {
                                setState(() {
                                  setState(() {
                                    _isCollapsed = true;
                                    _orangeAlert = false;

                                    _controller!.reverse();

                                    isScrollDown = false;
                                  });
                                });
                              } else if (isScrollDown == false) {
                                setState(() {
                                  if (isAnimationCompleted) {
                                    if (_isWeekly) {
                                      _orangeAlert = true;
                                      _translateOvalInit = 100.0;
                                    } else {
                                      _translateOvalInit = -18.0;
                                    }
                                    _leaderboarInit = 3;
                                    _controller!.reverse();
                                  } else {
                                    if (_isWeekly) {
                                      _orangeAlert = false;
                                    }
                                    _leaderboarInit = 0;
                                    _translateOvalInit = 80.0;
                                    _controller!.forward();
                                  }
                                  _isCollapsed = !_isCollapsed;
                                  isAnimationCompleted = !isAnimationCompleted;
                                  isScrollDown = true;
                                  _initTween();
                                });
                              }
                            }
                            //How many pixels scrolled from pervious frame

                            //List scroll position
                            return true;
                          },
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Wrap(
                              children: _leaderboards
                                  .getRange(
                                      _leaderboarInit, _leaderboards.length)
                                  .map(
                                    (e) => Container(
                                      margin: EdgeInsets.only(
                                        // top: ScreenUtil().setHeight(10),
                                        left: ScreenUtil().setWidth(16),
                                        right: ScreenUtil().setWidth(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setWidth(16)),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setSp(20)),
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: ScreenUtil().setWidth(24),
                                              height:
                                                  ScreenUtil().setHeight(24),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: ColorsHelpers.grey4,
                                                  width: 1.5,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: widgetText(
                                                e['number'].toString(),
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setWidth(10)),
                                            child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      ScreenUtil().setWidth(4)),
                                                  child: SvgPicture.asset(
                                                      e['avatar'].toString()),
                                                ),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight: ScreenUtil()
                                                        .setWidth(20),
                                                    maxWidth: ScreenUtil()
                                                        .setWidth(20),
                                                  ),
                                                  child: Image.asset(
                                                      e['flag'].toString()),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(16)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  widgetText(
                                                    e['name'].toString(),
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  widgetText(
                                                    '${e["point"]} points',
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorsHelpers.grey2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          e['medal'] != null
                                              ? SvgPicture.asset(
                                                  e['medal'].toString())
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
