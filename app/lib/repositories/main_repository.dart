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
}
