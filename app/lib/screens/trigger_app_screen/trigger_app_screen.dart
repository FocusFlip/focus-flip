import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/cubits/main_screen/main_screen_cubit.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/predefined_app_list_repository.dart';
import 'package:focus_flip/screens/main_screen/components/choose_app_dialog.dart';
import 'package:focus_flip/screens/main_screen/components/inline_label_list.dart';
import 'package:focus_flip/screens/trigger_app_screen/components/confirmation_dialog.dart';
import 'package:focus_flip/screens/trigger_app_screen/components/tutorial_item.dart';
import 'package:focus_flip/screens/trigger_app_screen/components/youtube_video_placeholder.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/toasts.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class TriggerAppScreen extends StatelessWidget {
  TriggerAppScreen({super.key, required this.mainScreenCubit});

  final MainScreenCubit mainScreenCubit;
  final textFieldFocusNode = FocusNode();

  void _onSubmitTriggerApp(BuildContext context, TriggerApp? app) {
    if (app == null) {
      showToast("You have not selected any app");
      return;
    }
    mainScreenCubit.addTriggerApp(app);
    Navigator.pop(context);
  }

  void _requestRemoveTriggerApp(BuildContext context, TriggerApp app) {
    showConfirmationDialog(
        context: context,
        title: "Disable FocusFlip for ${app.name}",
        content: "Are you sure you want to disable FocusFlip for ${app.name}?",
        onConfirm: () => mainScreenCubit.removeTriggerApp(app),
        onCancel: () {});
  }

  void _openTriggerAppSelection(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ChooseAppDialog<TriggerApp>(
            onSubmit: _onSubmitTriggerApp,
            title: "Add a trigger app",
            apps: PredefinedAppListRepository.triggerApps);
      },
    );
  }

  Widget _triggerAppListBuilder(BuildContext context, MainScreenState state) {
    List<Label> labels = [];
    for (TriggerApp triggerApp in state.triggerApps) {
      labels.add(Label(
          text: triggerApp.name,
          isActive: true,
          trailing: GestureDetector(
            onTap: () => _requestRemoveTriggerApp(context, triggerApp),
            child: Icon(Icons.close,
                color: ColorsHelpers.primaryColor,
                size: ScreenUtil().setSp(16)),
          )));
    }
    labels.add(
        Label(text: "+ Add", onTap: () => _openTriggerAppSelection(context)));

    return InlineLabelList(
      labels: labels,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Trigger App',
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
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(104)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                color: Colors.white),
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(16),
                bottom: ScreenUtil().setWidth(32)),
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
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  child: widgetText(
                    '1. Select a trigger app',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'Trigger app is an addictive app that you would like to avoid. Usually, social media belong to this category.',
                    color: ColorsHelpers.grey1,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                    child: BlocBuilder<MainScreenCubit, MainScreenState>(
                      bloc: mainScreenCubit,
                      builder: _triggerAppListBuilder,
                    )),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  child: widgetText(
                    '2. Setup a Shortcut automation',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TutorialItem(
                  title: '2.1 Open the Shortcuts app',
                  imagePath: Images.triggerAppShortcutTutorial1,
                ),
                TutorialItem(
                  title: '2.2 Open the category "Automation" (1) and '
                      ' create a new automation (2)',
                  imagePath: Images.triggerAppShortcutTutorial2,
                ),
                TutorialItem(
                  title: '2.3 Choose an "App" automation',
                  imagePath: Images.triggerAppShortcutTutorial3,
                ),
                TutorialItem(
                  title: '2.4 Set the automation run immediately when your '
                      'trigger app is opened',
                  imagePath: Images.triggerAppShortcutTutorial4,
                ),
                TutorialItem(
                  title: '2.5 Next, create a "New Blank Automation"',
                  imagePath: Images.triggerAppShortcutTutorial5,
                ),
                TutorialItem(
                  title: '2.6 Add an action',
                  imagePath: Images.triggerAppShortcutTutorial6,
                ),
                TutorialItem(
                  title: '2.7 To add an action, search for "FocusFlip" and '
                      'select "FocusFlip" from the list of apps',
                  imagePath: Images.triggerAppShortcutTutorial7,
                ),
                TutorialItem(
                  title:
                      '2.8 The app will provide a list of actions to choose from. '
                      'Select "Trigger App Opened".',
                  imagePath: Images.triggerAppShortcutTutorial8,
                ),
                TutorialItem(
                  title: '2.9 Then, select your trigger app in the parameters '
                      'of this action (1) and finish creating the automation (2)',
                  imagePath: Images.triggerAppShortcutTutorial9,
                ),
                TutorialItem(
                  title: '2.10 Now, the automation is ready to use and can be '
                      'found in the "Automation" tab of the Shortcuts app. You '
                      'have to create a similar automation for every trigger app'
                      ' selected above',
                  imagePath: Images.triggerAppShortcutTutorial10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
