
import 'package:countries_app/constants.dart';
import 'package:countries_app/screens/startup/startup_screen.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localization/localization.dart';


import 'locater.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  setupLocator();
  await locator<HiveService>().openBoxes();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
  static MainAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainAppState>();
  }
}

class MainAppState extends State<MainApp> {
  String? locale;
  @override
  void initState() {
    LocalJsonLocalization.delegate.directories = ['lib/i18n/'];
    locale = getAppLocaleFromLanguage(locator<HiveService>().getValue<String>(
          boxName: languageHiveBox,
          key: languageHiveKey,
        ) ??
        "en");

    print("====== $locale");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("====== $locale");
    LocalJsonLocalization.delegate.directories = ['lib/i18n/'];
    return MaterialApp(
        locale: Locale(locale ?? "en"),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocalJsonLocalization.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        debugShowCheckedModeBanner: false,
        home: const StartupScreen());
  }

  void rebuild() {
    String appLanguage = locator<HiveService>().getValue<String>(
          boxName: languageHiveBox,
          key: languageHiveKey,
        ) ??
        "English";
    print("********soso");
    print(appLanguage);
    locale = getAppLocaleFromLanguage(appLanguage);

    setState(() {});
  }

  String getAppLocaleFromLanguage(String appLanguage) {
    switch (appLanguage) {
      case "Arabic":
        return "ar";
      default:
        return "en";
    }
  }
}
