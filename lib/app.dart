import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/startup/startup_screen.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    locale = locator<HiveService>().getValue<String>(
          boxName: AppConstants.hiveBox,
          key: AppConstants.languageHiveKey,
        ) ??
        AppConstants.enLocale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(locale ?? AppConstants.enLocale),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale(AppConstants.enLocale),
        Locale(AppConstants.arLocale),
      ],
      debugShowCheckedModeBanner: false,
      home: const StartupScreen(),
    );
  }

  void rebuild() {
    String appLanguage = locator<HiveService>().getValue<String>(
          boxName: AppConstants.hiveBox,
          key: AppConstants.languageHiveKey,
        ) ??
        AppConstants.enLocale;
    locale = appLanguage;

    setState(() {});
  }
}
