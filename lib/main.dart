import 'package:countries_app/screens/startup/startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

void main() {
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
    rebuild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale(locale ?? "en"),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocalJsonLocalization.delegate,
        ],
        supportedLocales: [Locale(locale ?? "en")],
        debugShowCheckedModeBanner: false,
        home: const StartupScreen());
  }

  void rebuild() {
    var appLanguage = "English";
    locale = getAppLocaleFromLanguage(appLanguage);
    setState(() {});
  }

  String getAppLocaleFromLanguage(String appLanguage) {
    switch (appLanguage) {
      case "Arabic":
        return "ar";
      case "English":
        return "en";
      default:
        return "en";
    }
  }
}
