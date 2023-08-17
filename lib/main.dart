import 'package:countries_app/constants.dart';
import 'package:countries_app/screens/startup/startup_screen.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    // LocalJsonLocalization.delegate.directories = ['lib/i18n/'];
    locale = locator<HiveService>().getValue<String>(
          boxName: languageHiveBox,
          key: languageHiveKey,
        ) ??
        enLocale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale(locale ?? enLocale),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale(enLocale),
          Locale(arLocale),
        ],
        debugShowCheckedModeBanner: false,
        home: const StartupScreen());
  }

  void rebuild() {
    String appLanguage = locator<HiveService>().getValue<String>(
          boxName: languageHiveBox,
          key: languageHiveKey,
        ) ??
        enLocale;
    locale = appLanguage;

    setState(() {});
  }
}
