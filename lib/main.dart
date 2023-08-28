import 'dart:async';
import 'package:countries_app/app.dart';
import 'package:countries_app/constants.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'locater.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    setupLocator();
    await locator<HiveService>().openBoxes();
    return runApp(const MainApp());
  }, (error, stack) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppConstants.primaryColor,
        textColor: Colors.white);
    if (kDebugMode) {
      print(error);
      print(stack);
    }
  });
}
