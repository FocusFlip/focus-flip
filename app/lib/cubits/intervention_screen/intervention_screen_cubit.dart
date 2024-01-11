import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'intervention_screen_state.dart';

class InterventionScreenCubit extends Cubit<InterventionScreenState> {
  static final InterventionScreenCubit instance = InterventionScreenCubit();
  InterventionScreenCubit() : super(IntenventionScreenClosed());

  void open() {
    print("[InterventionScreenCubit] Opening InterventionScreen");
    if (state is IntenventionScreenClosed) {
      print("[InterventionScreenCubit] Pushing InterventionScreen");
      emit(PushInterventionScreen());
    } else {
      print("[InterventionScreenCubit] InterventionScreen is already open");
    }
  }

  void markAsOpened() {
    print("[InterventionScreenCubit] InterventionScreen has been opened");
    emit(InterventionScreenOpened());
  }

  void markAsClosed() {
    print("[InterventionScreenCubit] InterventionScreen has been closed");
    emit(IntenventionScreenClosed());
  }
}
