import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/cubits/main_screen/main_screen_cubit.dart';
import 'package:focus_flip/screens/healthy_app_screen/healty_app_screen.dart';
import 'package:focus_flip/screens/intervention_time_setting_screen/intervention_time_setting_screen.dart';
import 'package:focus_flip/screens/test_deep_links_screen.dart/test_deep_links_screen.dart';
import 'package:focus_flip/screens/trigger_app_screen/trigger_app_screen.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class MainScreenLayout extends StatelessWidget {
  final MainScreenCubit mainScreenCubit;

  const MainScreenLayout({super.key, required this.mainScreenCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
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
                                    Icons.favorite,
                                    size: 20.0,
                                    color: ColorsHelpers.pinkAccent,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(8)),
                                    child: widgetText('WE CHANGE YOUR HABITS',
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: ColorsHelpers.pinkAccent),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(5)),
                                child: widgetText('FocusFlip',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                      padding: const EdgeInsets.all(24),
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height / 2,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(32),
                              topLeft: Radius.circular(32))),
                      child: BlocBuilder<MainScreenCubit, MainScreenState>(
                        bloc: mainScreenCubit,
                        builder: (BuildContext context, MainScreenState state) {
                          // Trigger App
                          String triggerAppSubtitle = state.triggerApps.isEmpty
                              ? 'Not chosen yet'
                              : state.triggerApps.length == 1
                                  ? state.triggerApps[0].name
                                  : '${state.triggerApps[0].name} and ${state.triggerApps.length - 1} more';
                          Color triggerAppSubtitleColor =
                              state.triggerApps.isEmpty
                                  ? ColorsHelpers.red
                                  : ColorsHelpers.grey2;

                          // Healthy App
                          String healthyAppSubtitle = state.healthyApp == null
                              ? 'Not chosen yet'
                              : state.healthyApp!.name;
                          Color healthyAppSubtitleColor =
                              state.healthyApp == null
                                  ? ColorsHelpers.red
                                  : ColorsHelpers.grey2;

                          // Intervention Time
                          String interventionTimeSubtitle =
                              state.requiredHealthyTime.inSeconds.toString() +
                                  ' seconds';

                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widgetText('Set up your intervention',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(20),
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                    align: TextAlign.left),
                                const SizedBox(
                                  height: 16,
                                ),
                                widgetRichText(
                                  context,
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                          text:
                                              "Whenever you open an addictive "),
                                      TextSpan(
                                          text: "trigger app",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                      TextSpan(
                                          text:
                                              ", FocusFlip asks you to spend some time in a "),
                                      TextSpan(
                                          text: "healthy app",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                      TextSpan(
                                          text: " before to unlock it."
                                              "\n\nThis intervation aims to "),
                                      TextSpan(
                                          text: "fix your dopamine system",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: " by delaying"
                                              " the dopamine reward caused by the trigger app. "
                                              "This way, FocusFlip also motivates you "
                                              "to use healthy apps more often."),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(16)),
                                  child: listItem(
                                      Icon(
                                        Icons.app_blocking,
                                        size: ScreenUtil().setHeight(30),
                                        color: ColorsHelpers.orange,
                                      ),
                                      'Trigger app',
                                      triggerAppSubtitle, () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TriggerAppScreen(
                                                  mainScreenCubit:
                                                      mainScreenCubit,
                                                )));
                                  }, Colors.white, Colors.black,
                                      triggerAppSubtitleColor),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(16)),
                                  child: listItem(
                                      Icon(
                                        Icons.school,
                                        size: ScreenUtil().setHeight(30),
                                        color: ColorsHelpers.green,
                                      ),
                                      'Healthy app',
                                      healthyAppSubtitle, () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HealthyAppScreen(
                                                  mainScreenCubit:
                                                      mainScreenCubit,
                                                )));
                                  }, Colors.white, Colors.black,
                                      healthyAppSubtitleColor),
                                ),
                                listItem(
                                    Icon(
                                      Icons.timer,
                                      size: ScreenUtil().setHeight(30),
                                      color: ColorsHelpers.dullLavender,
                                    ),
                                    'Intervention time',
                                    interventionTimeSubtitle, () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InterventionTimeSettingScreen(
                                                mainScreenCubit:
                                                    mainScreenCubit,
                                              )));
                                }, Colors.white, Colors.black,
                                    ColorsHelpers.grey2),
                                kDebugMode
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(16)),
                                        child: listItem(
                                            Icon(
                                              Icons.settings,
                                              size: ScreenUtil().setHeight(30),
                                              color: Colors.black,
                                            ),
                                            'Test deep links',
                                            '[Only in debug mode]', () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TestDeepLinksScreen()));
                                        }, Colors.white, Colors.black,
                                            healthyAppSubtitleColor),
                                      )
                                    : SizedBox.shrink(),
                              ]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
