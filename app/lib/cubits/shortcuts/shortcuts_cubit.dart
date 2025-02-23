import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:focus_flip/cubits/shortcuts/heathy_app_intervention_state.dart';

import '../../models/app.dart';

part 'shortcuts_state.dart';

class ShortcutsCubit extends Cubit<ShortcutsState> {
  static final ShortcutsCubit instance = ShortcutsCubit._();
  ShortcutsCubit._() : super(ShortcutsNotInitialized());

  MethodChannel _methodChannel = const MethodChannel("com.FocusFlip/shortcuts");

  void init() {
    assert(state is ShortcutsNotInitialized);
    assert(Platform.isIOS);

    _methodChannel.setMethodCallHandler(_methodCallHandler);
    print("ShortcutsCubit initialized");
    emit(ShortcutsInitialized());
  }

  Future<dynamic> _methodCallHandler(MethodCall call) {
    assert(!(state is ShortcutsNotInitialized));

    print("[ShortcutsCubit] Dart method invoked: ${call.method}");
    if (call.method == "triggerAppOpened") {
      _triggerAppOpened(call.arguments["appName"]);
    } else {
      throw UnimplementedError();
    }
    return Future.value();
  }

  void _triggerAppOpened(String appName) {
    print("""[ShortcutsCubit] App "$appName" has been opened.""");
    emit(TriggerAppOpenedShortcut(appName));
  }

  /// Disables the intervention for the given [triggerApp]. This method is
  /// called when the intervention has been finished and prevents the trigger app
  /// from being interrupted again.
  Future<bool> disableIntervention(TriggerApp triggerApp) async {
    assert(!(state is ShortcutsNotInitialized));

    print("[ShortcutsCubit] Disabling intervention for ${triggerApp.name}");
    bool? result = await _methodChannel.invokeMethod<bool>(
        "disableIntervention", {"appName": triggerApp.name});

    return result ?? false;
  }

  /// Marks the healthy app as launched. The iOS platform remembers the starting
  /// time of the healthy app and uses it to calculate the time the user has
  /// spent in the healthy app.
  Future<bool> markHealthyAppInterventionAsStarted(
      Duration requiredInterventionTime) async {
    assert(!(state is ShortcutsNotInitialized));

    double requiredInterventionTimeInSeconds =
        requiredInterventionTime.inSeconds.toDouble();

    print("[ShortcutsCubit] Marking healthy app as launched");
    bool? result = await _methodChannel.invokeMethod<bool>(
        "markHealthyAppInterventionAsStarted", {
      "requiredInterventionTimeInSeconds": requiredInterventionTimeInSeconds
    });

    return result ?? false;
  }

  Future<HealthyAppInterventionState> getHealthyAppInterventionState() async {
    assert(!(state is ShortcutsNotInitialized));

    print("[ShortcutsCubit] Getting healthy app intervention state");
    String? result = await _methodChannel
        .invokeMethod<String>("getHealthyAppInterventionState");

    if (result == "started") {
      return HealthyAppInterventionState.started;
    } else if (result == "interrupted") {
      return HealthyAppInterventionState.interrupted;
    } else if (result == "reward") {
      return HealthyAppInterventionState.reward;
    } else if (result == "inactive") {
      return HealthyAppInterventionState.inactive;
    } else {
      throw Exception("Unknown healthy app intervention state: $result");
    }
  }
}
