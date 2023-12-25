import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  void addTriggerApp() {
    throw UnimplementedError();
  }

  void clearTriggerApps() {
    throw UnimplementedError();
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
