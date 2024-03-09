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
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/toasts.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class HealthyAppScreen extends StatelessWidget {
  HealthyAppScreen({super.key, required this.mainScreenCubit});

  final MainScreenCubit mainScreenCubit;
  final textFieldFocusNode = FocusNode();

  void _onSubmitHealthyApp(BuildContext context, HealthyApp? app) {
    if (app == null) {
      showToast("You have not selected any app");
      return;
    }
    mainScreenCubit.setHealthyApp(app);
    Navigator.pop(context);
  }

  void _requestRemoveHealthyApp(BuildContext context, HealthyApp app) {
    showConfirmationDialog(
        context: context,
        title: "Disable ${app.name} as a healthy app",
        content:
            "Are you sure you want to disable ${app.name} as a healthy app?",
        onConfirm: () {
          mainScreenCubit.setHealthyApp(null);
        },
        onCancel: () {});
  }

  void _openTriggerAppSelection(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ChooseAppDialog<HealthyApp>(
            onSubmit: _onSubmitHealthyApp,
            title: "Add a trigger app",
            apps: PredefinedAppListRepository.healthyApps);
      },
    );
  }

  Widget _triggerAppListBuilder(BuildContext context, MainScreenState state) {
    List<Label> labels = [];
    HealthyApp? healthyApp = state.healthyApp;
    if (healthyApp != null) {
      labels.add(Label(
          text: healthyApp.name,
          isActive: true,
          trailing: GestureDetector(
            onTap: () => _requestRemoveHealthyApp(context, healthyApp),
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
        title: widgetText('Healthy App',
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
                    '1. Select a healthy app',
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  alignment: Alignment.topLeft,
                  child: widgetText(
                    'Healthy app is an app that you want to use more often'
                    ' instead of trigger apps. For example, you may want to use'
                    ' a flashcard app to study more often.',
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
                  imagePath: Images.healthyAppShortcutTutorial1,
                ),
                TutorialItem(
                  title: '2.2 Open the category "Automation" (1) and '
                      ' create a new automation (2)',
                  imagePath: Images.healthyAppShortcutTutorial2,
                ),
                TutorialItem(
                  title: '2.3 Choose an "App" automation',
                  imagePath: Images.healthyAppShortcutTutorial3,
                ),
                TutorialItem(
                  title: '2.4 Set the automation run immediately when your '
                      'healthy app is closed. Remember to disable running on '
                      ' opening the app if it was enabled before',
                  imagePath: Images.healthyAppShortcutTutorial4,
                ),
                TutorialItem(
                  title: '2.5 Next, create a "New Blank Automation"',
                  imagePath: Images.healthyAppShortcutTutorial5,
                ),
                TutorialItem(
                  title: '2.6 Add an action',
                  imagePath: Images.healthyAppShortcutTutorial6,
                ),
                TutorialItem(
                  title: '2.7 To add an action, search for "FocusFlip" and '
                      'select "FocusFlip" from the list of apps',
                  imagePath: Images.healthyAppShortcutTutorial7,
                ),
                TutorialItem(
                  title:
                      '2.8 The app will provide a list of actions to choose from. '
                      'Select "Healthy App Closed".',
                  imagePath: Images.healthyAppShortcutTutorial8,
                ),
                TutorialItem(
                  title: '2.9 Then, you can finish the automation creation',
                  imagePath: Images.healthyAppShortcutTutorial9,
                ),
                TutorialItem(
                  title: '2.10 Now, the automation is ready to use and can be '
                      'found in the "Automation" tab of the Shortcuts app',
                  imagePath: Images.healthyAppShortcutTutorial10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
