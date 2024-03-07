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

  // TODO: Remove when you use the API to define url and package name
  final List<TriggerApp> _triggerApps = [
    TriggerApp(
        name: "YouTube",
        url: "youtube://",
        packageName: "com.google.android.youtube"),
  ];

  List<TriggerApp> get triggerApps {
    try {
      print("[Hiverepository] Reading triggerApps from the box");
      box.get('triggerApps').cast<TriggerApp>().forEach((element) {
        print(element.name);
      });
      return box.get('triggerApps').cast<TriggerApp>();
    } catch (e) {
      print(e);
    }
    return [];
  }

  void addHealthyAppInRepo() {
    print("[MainRepository] writeHealthyAppInMain");
    instance.addHealthyApp(healthyApp);
  }

  void addTriggerAppInRepo() {
    print("[MainRepository] writeTriggerAppInMain");

    instance.addTriggerApps(triggerApps);
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

  // TODO: store in HiveDB
  HealthyApp get healthyApp {
    return HealthyApp(
        name: "Anki",
        url: "anki://",
        packageName: "com.ichi2.anki",
        requiredUsageDuration:
            Duration(seconds: instance.readRequiredHealthyTime()));
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
      return instance.box.get("requiredHealthyTime");
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

  //TODO - Add the model for hive to recognize the object
  void addHealthyApps(List<HealthyApp> _healthyApps) {
    print("[Hiverepository] Writing healthyApps to the box");
    box.put('healthyApps', _healthyApps);

    print("[Hiverepository] Reading healthyApps from the box");
    box.get('healthyApps');
  }

  //TODO - Add the model for hive to recognize the object
  void addHealthyApp(HealthyApp _healthyApp) {
    print("[HiveBox] Writing healthyApp to the box");
    box.put('healthyApp', _healthyApp);
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
