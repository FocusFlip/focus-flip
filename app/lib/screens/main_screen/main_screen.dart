import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/cubits/main_screen/main_screen_cubit.dart';
import 'package:focus_flip/cubits/shortcuts/shortcuts_cubit.dart';
import 'package:focus_flip/repositories/main_repository.dart';
import 'package:focus_flip/utils/apps_utils.dart';
import 'package:focus_flip/utils/toasts.dart';
import 'package:focus_flip/utils/widget_assets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../cubits/intervention_screen/intervention_screen_cubit.dart';
import '../../models/app.dart';
import '../../utils/constant.dart';
import '../intervention_screen/intervention_screen.dart';
import 'components/add_trigger_app_dialog.dart';
import 'components/inline_label_list.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenCubit _cubit = MainScreenCubit(MainRepository.instance);
  final InterventionScreenCubit _interventionScreenCubit =
      InterventionScreenCubit.instance;

  void _addTriggerApp(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AddTriggerAppDialog(
          onSubmit: _cubit.addTriggerApp,
          cubit: _cubit,
        );
      },
    );
  }

  void _cubitListener(BuildContext context, MainScreenState state) {
    if (state is TriggerAppsCleared) {
      showToast("All trigger apps have been removed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isIOS) {
      ShortcutsCubit.instance.stream.listen((state) {
        print("[MainScreen] ShortuctsCubit state updated: $state");
        if (state is TriggerAppOpenedShortcut) {
          TriggerApp triggerApp = getTriggerAppByName(state.appName);
          _interventionScreenCubit.openScreen(triggerApp);
        }
      });
      if (ShortcutsCubit.instance.state is TriggerAppOpenedShortcut) {
        TriggerAppOpenedShortcut state =
            ShortcutsCubit.instance.state as TriggerAppOpenedShortcut;
        TriggerApp triggerApp = getTriggerAppByName(state.appName);
        _interventionScreenCubit.openScreen(triggerApp);
      }

      _interventionScreenCubit.stream.listen((state) {
        print("[MainScreen] InterventionScreenCubit state updated: $state");

        if (state is PushInterventionScreen) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InterventionScreen(
                        initialTriggerApp: state.triggerApp,
                      )));
        }
      });
      InterventionScreenState interventionScreenState =
          _interventionScreenCubit.state;
      if (interventionScreenState is PushInterventionScreen) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InterventionScreen(
                    initialTriggerApp: interventionScreenState.triggerApp)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainScreenCubit, MainScreenState>(
        bloc: _cubit,
        listener: _cubitListener,
        builder: (context, state) => GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: widgetText('FocusFlip',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(24),
                    fontWeight: FontWeight.w500),
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(24),
                    right: ScreenUtil().setHeight(24)),
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // TRIGGER APPS
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(104)),
                        child: widgetText(
                          'TRIGGER APPS',
                          color: ColorsHelpers.neutralOpacity0_5,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500,
                          letterSpacing: ScreenUtil().setSp(1.2),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        child: widgetText(
                            'These are apps that you would like to avoid, but you spend too much time with them and likely open them automatically. Usually, social media belong to this category.',
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w400),
                      ),

                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                        child: InlineLabelList(
                          labels: state.triggerApps
                              .map((app) =>
                                  Label(text: app.name, isActive: true))
                              .toList()
                            ..add(Label(
                                text: "+ Add",
                                onTap: () {
                                  // _cubit.addTriggerApp
                                  _addTriggerApp(context);
                                })),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(32),
                          bottom: ScreenUtil().setHeight(56),
                        ),
                        child: GestureDetector(
                            onTap: _cubit.clearTriggerApps,
                            child: widgetText(
                              'Clear trigger apps',
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            )),
                      ),

                      // HEALTHY ALTERNATIVES
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        child: widgetText(
                          'HEALTHY ALTERNATIVES',
                          color: ColorsHelpers.neutralOpacity0_5,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500,
                          letterSpacing: ScreenUtil().setSp(1.2),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        child: widgetText(
                            'Healthy alternatives are apps that you would prefer to spend more time with than trigger apps. For example: Anki, language learning apps, book reader etc.',
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                          child: InlineLabelList(
                            labels: [
                              // TODO: replace the example below
                              Label(
                                  text: "Anki",
                                  isActive: true,
                                  onTap: () async {
                                    final Uri url = Uri.parse('anki://');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  }),
                              Label(text: "+ Add", onTap: _cubit.addHealthyApp)
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(32),
                          bottom: ScreenUtil().setHeight(56),
                        ),
                        child: GestureDetector(
                          onTap: _cubit.clearHealthyApps,
                          child: widgetText(
                            'Clear healthy alternatives',
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                      ),

                      // REQUIRED HEALTHY TIME
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        child: widgetText(
                          'REQUIRED HEALTHY TIME (MINUTES)',
                          color: ColorsHelpers.neutralOpacity0_5,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500,
                          letterSpacing: ScreenUtil().setSp(1.2),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        child: widgetText(
                            'Every time you open a trigger app you will have to spend a selected amount of time in a healthy alternative app first. After that, you can continue to the trigger app.\n\nProbably, you will even stay on the healthy alternative because this intervention helps overcome the most difficult stage of a productive activity: starting it.',
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10),
                            bottom: ScreenUtil().setHeight(32) +
                                MediaQuery.of(context).viewPadding.bottom),
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorsHelpers.grey5, width: 2.5),
                                borderRadius: BorderRadius.circular(20.0)),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            contentPadding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(16),
                              bottom: ScreenUtil().setWidth(16),
                              left: ScreenUtil().setWidth(24),
                              right: ScreenUtil().setWidth(24),
                            ),
                            hintText: 'Time in seconds',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(16),
                                color: ColorsHelpers.grey2),
                          ),
                          initialValue:
                              state.requiredHealthyTime?.inSeconds.toString(),
                          onChanged: (value) {
                            _cubit.updateRequiredHealthyTime(value);
                          },
                        ),
                      ),
                      if (Platform.isAndroid) ...[
                        // BACKGROUND APP USAGE TRACKING
                        Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                          child: widgetText(
                            'BACKGROUND APP USAGE TRACKING',
                            color: ColorsHelpers.neutralOpacity0_5,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500,
                            letterSpacing: ScreenUtil().setSp(1.2),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                          child: widgetText(
                              'Only Android requires this setting. It allows FocusFlip to track your app usage in the background and to intervene when you open a trigger app.',
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(16),
                              bottom: ScreenUtil().setHeight(56)),
                          child: GestureDetector(
                            onTap: () {
                              _interventionScreenCubit
                                  .startBackgroundAppUsageTracking();
                            },
                            child: widgetText(
                              'Enable background app usage tracking',
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(56)),
                          child: GestureDetector(
                            onTap: () async {
                              await FlutterBackground
                                  .disableBackgroundExecution();
                              print("Background execution disabled");
                            },
                            child: widgetText(
                              'Disable background app usage tracking',
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            )));
  }
}
