import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'intervention_screen_state.dart';

class InterventionScreenCubit extends Cubit<InterventionScreenState> {
  static final InterventionScreenCubit instance = InterventionScreenCubit();
  InterventionScreenCubit() : super(IntenventionScreenClosed());

  void openScreen() {
    print("[InterventionScreenCubit] Opening InterventionScreen");
    if (state is IntenventionScreenClosed) {
      print("[InterventionScreenCubit] Pushing InterventionScreen");
      emit(PushInterventionScreen());
    } else if (state is InterventionScreenOpened) {
      print("[InterventionScreenCubit] Refreshing InterventionScreen");
      emit(InterventionScreenOpened(
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

  void markAsOpened() {
    print("[InterventionScreenCubit] InterventionScreen has been opened");
    emit(InterventionScreenOpened(
        timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  void markAsClosed() {
    print("[InterventionScreenCubit] InterventionScreen has been closed");
    emit(IntenventionScreenClosed());
  }
}
