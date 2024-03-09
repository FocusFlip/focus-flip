import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/hive_box_repository.dart';

/**
 * This class is used as key-value storage for the values that are used throughout the app.
 * 
 * The values are stored in a Hive box named "main".
 * When the app is started, the box is opened and the values are loaded.
 */
class MainRepository extends HiveBoxRepository {
  static final MainRepository instance = MainRepository("main");

  MainRepository(hiveBoxName) : super(hiveBoxName);

  List<TriggerApp> get triggerApps {
    try {
      print("[Hiverepository] Reading triggerApps from the box");
      List<TriggerApp>? triggerApps =
          box.get('triggerApps')?.cast<TriggerApp>().toList();

      return triggerApps ?? [];
    } catch (e) {
      print(e);
    }
    return [];
  }

  void addTriggerApp(TriggerApp app) {
    // TODO: check if we need verify by url or package name
    // It is not needed on iOS because a predefined list of apps is used,
    // but the available apps for android are not known in advance.
    if (triggerApps.any((element) => element.name == app.name)) {
      throw DuplicateException(duplicateField: "name");
    }
    putTriggerAppList(triggerApps..add(app));
    print("Add TriggerApp.");
  }

  void removeTriggerApp(TriggerApp app) {
    var triggerAppsNumber = triggerApps.length;
    putTriggerAppList(
        triggerApps..removeWhere((element) => element.name == app.name));
    var newTriggerAppsNumber = triggerApps.length;
    print(
        "Remove TriggerApp. Number of TriggerApps before: $triggerAppsNumber, after: $newTriggerAppsNumber");
  }

  HealthyApp? get healthyApp {
    return box.get('healthyApp');
  }

  set healthyApp(HealthyApp? app) {
    box.put('healthyApp', app);
  }

//TODO - Fix Error Handling and displaying the message in higher level
  void updateRequiredHealthyTime(int value) {
    print("[MainRepository] updateRequiredHealthyTimeInMain");
    instance.box.put("requiredHealthyTime", value);
    print("[MainRepository] Read RequiredHealthyTime in the box");
    readRequiredHealthyTime();
  }

  int readRequiredHealthyTime() {
    try {
      print("[MainRepository] Reading RequiredHealthyTime in the box");
      print(instance.box.get("requiredHealthyTime"));
      return instance.box.get("requiredHealthyTime", defaultValue: 20);
    } catch (e) {
      print(e);
    }
    //default time set to 20 seconds
    return 20;
  }

  //TODO - Add the model for hive to recognize the object
  void putTriggerAppList(List<TriggerApp> _triggerApps) {
    print("[Hiverepository] Writing triggerApps to the box");
    box.put('triggerApps', _triggerApps);
    triggerApps;
  }
}

class WrongValueException implements Exception {
  final String message;
  WrongValueException({required this.message});
}

class DuplicateException implements Exception {
  final String duplicateField;
  DuplicateException({required this.duplicateField});
}
