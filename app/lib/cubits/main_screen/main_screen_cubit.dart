import 'package:bloc/bloc.dart';
import 'package:flutter_siri_suggestions/flutter_siri_suggestions.dart';
import 'package:meta/meta.dart';
import 'package:quezzy/models/trigger_app.dart';
import 'package:quezzy/repositories/main_repository.dart';
import 'package:uuid_type/uuid_type.dart';

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

    String activityTitle = "Trigger App Opened: " + app.name;
    String activityKey = app.name.replaceAll(" ", "") + "Triggered";
    FlutterSiriSuggestions.instance
        .registerActivity(FlutterSiriActivity(
      activityTitle,
      activityKey,
      isEligibleForSearch: false,
      isEligibleForPrediction: true,
      contentDescription: "Opens FocusFlip",
      suggestedInvocationPhrase:
          "Trigger app has been opened", /*persistentIdentifier: app.triggerShortcutPersistentIdentifier*/
    ))
        .then((value) {
      print("Siri activity has been created successfully");
    }).onError((error, stackTrace) {
      print("Error has occured when a Siri suggestion was been creating");
    });

    emit(TriggerAppAdded(triggerApps: state.triggerApps.toList()..add(app)));
  }

  void clearTriggerApps() {
    FlutterSiriSuggestions.instance
        .deleteAllSavedUserActivities()
        .then((value) {
      print("Siri Shortcuts have been removed");
    }).onError((error, stackTrace) {
      print("Error has occured when trying to remove all the Siri Shortcuts");
    });

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
