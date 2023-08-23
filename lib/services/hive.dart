import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';

class HiveService {
  //  Already open box
  late Box languageBox;

  Future<void> openBoxes() async {
    languageBox = await Hive.openBox(hiveBox);
  }

  Future<void> setValue<T>(
      {required String boxName, required String key, required T value}) async {
    switch (boxName) {
      case hiveBox:
        await languageBox.put(key, value);
        break;
    }
  }

  T? getValue<T>({required String boxName, required String key}) {
    switch (boxName) {
      case hiveBox:
        return languageBox.get(key);

      default:
        return null;
    }
  }
}
