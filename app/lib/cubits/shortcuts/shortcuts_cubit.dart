import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'shortcuts_state.dart';

class ShortcutsCubit extends Cubit<ShortcutsState> {
  static final ShortcutsCubit instance = ShortcutsCubit._();
  ShortcutsCubit._() : super(ShortcutsNotInitialized());

  MethodChannel _methodChannel =
      const MethodChannel("com.example.quezzy/shortcuts");

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
}
