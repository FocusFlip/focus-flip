import 'package:hive_flutter/hive_flutter.dart';

/**
 * Defines a repository based on Hive `Box` with the purpose 
 * to reuse the code for opening and closing the box.
 */
abstract class HiveBoxRepository {
  late final String boxName;
  HiveBoxRepository(this.boxName);

  late Box box;

  Future<void> openBox() async {
    await Hive.openBox(boxName);
    box = Hive.box(boxName);
  }

  Future<void> close() {
    return Hive.close();
  }
}
