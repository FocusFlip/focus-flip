import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/main_repository.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit(this.mainRepository)
      : super(MainScreenInitial(mainRepository.triggerApps,
            Duration(seconds: mainRepository.readRequiredHealthyTime())));
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

//TODO - Fix this method when the HealthyApp is selected from the list
  void addHealthyApp() {
    try {
      mainRepository.addHealthyApp(mainRepository.healthyApp);
    } on DuplicateException {
      return;
    } catch (e) {
      return;
    }
    // emit(HealthyAppAdded(mainRepository.healthyApp));
  }

  void clearHealthyApps() {
    throw UnimplementedError();
  }

  void updateRequiredHealthyTime(String value) {
    int? time = int.tryParse(value);

    //TODO - Display error message to user when wrong value is given
    if (time == null || time < 15) {
      emit(RequiredHealthyTimeError(
          state.triggerApps.toList(), Duration(seconds: 0)));
      return;
    }
    try {
      mainRepository.updateRequiredHealthyTime(time);
    } catch (e) {
      emit(RequiredHealthyTimeError(
          state.triggerApps.toList(), Duration(seconds: time)));
      return;
    }
    emit(UpdatedRequiredHealthyTime(
        state.triggerApps.toList(), Duration(seconds: time)));
  }
}
