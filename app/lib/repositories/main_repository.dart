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

  // TODO: store in HiveDB
  final List<TriggerApp> _triggerApps = [
    TriggerApp(
        name: "YouTube",
        url: "youtube://",
        packageName: "com.google.android.youtube"),
  ];

  List<TriggerApp> get triggerApps {
    return _triggerApps.toList();
  }

  void addTriggerApp(TriggerApp app) {
    if (_triggerApps.any((element) => element.name == app.name)) {
      throw DuplicateException(duplicateField: "name");
    }

    _triggerApps.add(app);
  }

  void clearTriggerApps() {
    _triggerApps.clear();
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
    print("[MainRepository] Reading RequiredHealthyTime in the box");
    print(instance.box.get("requiredHealthyTime"));
    return instance.box.get("requiredHealthyTime");
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
