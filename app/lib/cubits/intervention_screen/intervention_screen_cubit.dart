import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/trigger_app.dart';

part 'intervention_screen_state.dart';

class InterventionScreenCubit extends Cubit<InterventionScreenState> {
  static final InterventionScreenCubit instance = InterventionScreenCubit();
  InterventionScreenCubit() : super(IntenventionScreenClosed());

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
}
