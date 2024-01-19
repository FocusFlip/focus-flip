import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/app.dart';
import '../shortcuts/shortcuts_cubit.dart';

part 'intervention_screen_state.dart';

class InterventionScreenCubit extends Cubit<InterventionScreenState> {
  static final InterventionScreenCubit instance =
      InterventionScreenCubit(shortcutsCubit: ShortcutsCubit.instance);
  InterventionScreenCubit({required this.shortcutsCubit})
      : super(IntenventionScreenClosed());

  final ShortcutsCubit shortcutsCubit;

  void openScreen(TriggerApp triggerApp) {
    print("[InterventionScreenCubit] Opening InterventionScreen");
    if (state is IntenventionScreenClosed) {
      print("[InterventionScreenCubit] Pushing InterventionScreen");
      emit(PushInterventionScreen(triggerApp: triggerApp));
    } else if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Refreshing InterventionScreen");
      emit(InterventionScreenOpened(
          triggerApp: triggerApp,
          timestamp: DateTime.now().millisecondsSinceEpoch));
    }
  }

  void closeScreen() {
    print("[InterventionScreenCubit] Closing InterventionScreen");
    if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Popping InterventionScreen");
      emit(PopInterventionScreen());
    }
  }

  void markAsOpened(TriggerApp triggerApp) {
    print("[InterventionScreenCubit] InterventionScreen has been opened");
    emit(InterventionScreenOpened(
        triggerApp: triggerApp,
        timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  void markAsClosed() {
    print("[InterventionScreenCubit] InterventionScreen has been closed");
    emit(IntenventionScreenClosed());
  }

  Future<void> launchTriggerApp(TriggerApp triggerApp) async {
    print("[InterventionScreenCubit] Launching trigger app");

    bool interventionDisabled =
        await shortcutsCubit.disableIntervention(triggerApp);
    print(
        "[InterventionScreenCubit] Intervention disabled: $interventionDisabled");

    Uri uri = Uri.parse(triggerApp.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
