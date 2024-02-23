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

//TODO - Fix Error Handling
  void updateRequiredHealthyTimeInRepo(int value) {
    if (value <= 5 || value == null) {
      throw Exception("Value must be greater than 15");
    }
    print("[MainRepository] updateRequiredHealthyTimeInMain");
    instance.updateRequiredHealthyTime(value);
  }
}

class DuplicateException implements Exception {
  final String duplicateField;

  DuplicateException({required this.duplicateField});
}
