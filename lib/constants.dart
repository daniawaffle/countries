import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();
  static const String baseUrl = "https://www.helpera.app/";
  static const String hiveBox = "languageBox";
  static const String languageHiveKey = "languageKey";

  static const String imageBaseUrl = "https://www.helpera.app/static/countries/";
  static const String categoryImageBaseUrl = "https://www.helpera.app/static/categories/";
  static const String mentorImageUrl = "https://www.helpera.app/static/mentorsImg/";

  static const String userTokenKey = 'tokenKey';

  static const String authMethod = "client-auth-debug";
  static const String countriesMethod = "countries";
  static const String authVerifyMethod = "client-auth-verify";
  static const String appointmentMethod = "client-appointment/";
  static const String cancelAppointmentMethod = "client-appointment/cancel";

  static const String commentMethod = "client-appointment/comment";

  static const String enLocale = "en";
  static const String arLocale = "ar";
  static const String getMethod = "GET";
  static const String postMethod = "POST";
  static Color primaryColor = Colors.green.shade700;
  static Color secendaryColor = Colors.green.shade50;
  static Color selectedItemColor = Colors.green.shade300;
}
