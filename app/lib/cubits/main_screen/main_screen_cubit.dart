import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/main_repository.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit(this.mainRepository)
      : super(MainScreenInitial(triggerApps: []));
  final MainRepository mainRepository;

  Future<void> addTriggerApp(String name) async {
    if (name.isEmpty) {
      emit(EmptyNameError(triggerApps: state.triggerApps.toList()));
      return;
    }

    TriggerApp app = TriggerApp(
        name: name, url: "instagram://"); // TODO: change url to a valid one
    try {
      mainRepository.addTriggerApp(app);
    } on DuplicateException {
      emit(DuplicateNameError(triggerApps: state.triggerApps.toList()));
      return;
    } catch (e) {
      // TODO: error handling
      return;
    }

    emit(TriggerAppAdded(triggerApps: state.triggerApps.toList()..add(app)));
  }

  void clearTriggerApps() {
    mainRepository.clearTriggerApps();
    emit(TriggerAppsCleared(triggerApps: []));
  }

  void addHealthyApp() {
    throw UnimplementedError();
  }

  void clearHealthyApps() {
    throw UnimplementedError();
  }

  void updateRequiredHealthyTime(double value) {
    throw UnimplementedError();
  }
}
