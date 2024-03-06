import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/main_repository.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit(this.mainRepository)
      : super(MainScreenInitial(triggerApps: []));
  final MainRepository mainRepository;

  Future<void> addTriggerApp(TriggerApp app) async {
    try {
      mainRepository.addTriggerApp(app);
    } on DuplicateException {
      print("[MainScreenCubit] Duplicate trigger app");
      emit(DuplicateTriggerAppError(triggerApps: state.triggerApps.toList()));
      return;
    } catch (e) {
      // TODO: error handling
      return;
    }

    emit(TriggerAppAdded(triggerApps: state.triggerApps.toList()..add(app)));
  }

  void removeTriggerApp(TriggerApp app) {
    mainRepository.removeTriggerApp(app);
    emit(TriggerAppRemoved(
        removedApp: app, triggerApps: state.triggerApps.toList()..remove(app)));
  }

  void addHealthyApp() {
    throw UnimplementedError();
  }

  void clearHealthyApps() {
    throw UnimplementedError();
  }

  void updateRequiredHealthyTime(int value) {
    try {
      mainRepository.updateRequiredHealthyTime(value);
    } catch (e) {
      emit(RequiredHealthyTimeError(
          state.triggerApps.toList(), Duration(seconds: value)));
      return;
    }
    emit(UpdatedRequiredHealthyTime(
        state.triggerApps.toList(), Duration(seconds: value)));
  }
}
