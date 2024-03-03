import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focus_flip/cubits/main_screen/main_screen_cubit.dart';
import 'package:focus_flip/cubits/shortcuts/shortcuts_cubit.dart';
import 'package:focus_flip/repositories/main_repository.dart';
import 'package:focus_flip/screens/main_screen/components/main_screen_layout.dart';
import 'package:focus_flip/utils/apps_utils.dart';
import 'package:focus_flip/utils/toasts.dart';
import '../../cubits/intervention_screen/intervention_screen_cubit.dart';
import '../../models/app.dart';
import '../intervention_screen/intervention_screen.dart';
import 'components/add_trigger_app_dialog.dart';

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

  void _cubitListener(MainScreenState state) {
    if (state is TriggerAppsCleared) {
      showToast("All trigger apps have been removed");
    }
  }

  void _setShortcutsListener() {
    assert(Platform.isIOS);

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

  @override
  void initState() {
    super.initState();

    _cubit.stream.listen(_cubitListener);

    if (Platform.isIOS) {
      _setShortcutsListener();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenLayout();
  }
}
