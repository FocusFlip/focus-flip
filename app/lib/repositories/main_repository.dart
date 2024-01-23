import 'package:quezzy/models/app.dart';
import 'package:quezzy/repositories/hive_box_repository.dart';

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
  final List<TriggerApp> _triggerApps = [];

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
        requiredUsageDuration: Duration(seconds: 20));
  }
}

class DuplicateException implements Exception {
  final String duplicateField;

  DuplicateException({required this.duplicateField});
}
