import 'package:bloc/bloc.dart';
import 'package:focus_flip/utils/music_visualizer_main.dart';
import 'package:meta/meta.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/main_repository.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit(this.mainRepository)
      : super(MainScreenInitial(
          mainRepository.triggerApps,
          Duration(
            seconds: mainRepository.readRequiredHealthyTime(),
          ),
          mainRepository.healthyApp,
        ));
  final MainRepository mainRepository;

  Future<void> addTriggerApp(TriggerApp app) async {
    try {
      mainRepository.addTriggerApp(app);
    } on DuplicateException {
      print("[MainScreenCubit] Duplicate trigger app");
      emit(DuplicateTriggerAppError(
          triggerApps: state.triggerApps.toList(),
          healthyApp: state.healthyApp,
          requiredHealthyTime: state.requiredHealthyTime));
      return;
    } catch (e) {
      // TODO: error handling
      return;
    }

    emit(TriggerAppAdded(
        triggerApps: state.triggerApps.toList()..add(app),
        healthyApp: state.healthyApp,
        requiredHealthyTime: state.requiredHealthyTime));
  }

  void removeTriggerApp(TriggerApp app) {
    mainRepository.removeTriggerApp(app);
    emit(TriggerAppRemoved(
        removedApp: app,
        triggerApps: state.triggerApps.toList()..remove(app),
        healthyApp: state.healthyApp,
        requiredHealthyTime: state.requiredHealthyTime));
  }

  void setHealthyApp(HealthyApp? app) {
    mainRepository.healthyApp = app;
    emit(HealthyAppAdded(
        triggerApps: state.triggerApps,
        healthyApp: app,
        requiredHealthyTime: state.requiredHealthyTime));
  }

  void updateRequiredHealthyTime(String value) {
    int? time = int.tryParse(value);

    if (time == null) {
      emit(RequiredHealthyTimeError(
          state.triggerApps.toList(), Duration(seconds: 0), state.healthyApp));
      return;
    }
    try {
      mainRepository.updateRequiredHealthyTime(time);
    } catch (e) {
      emit(RequiredHealthyTimeError(state.triggerApps.toList(),
          Duration(seconds: time), state.healthyApp));
      return;
    }
    emit(UpdatedRequiredHealthyTime(
        state.triggerApps.toList(), Duration(seconds: time), state.healthyApp));
  }
}
