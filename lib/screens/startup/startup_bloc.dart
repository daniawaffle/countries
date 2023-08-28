import 'dart:async';
import 'package:countries_app/app.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/services/hive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../services/api.dart';

class StartupBloc {
  StreamController<List<Country>> countriesStreamController =
      StreamController<List<Country>>();

  Future<void> getCountries() async {
    final response = await locator<ApiService>().apiRequest(
      path: AppConstants.countriesMethod,
      method: AppConstants.getMethod,
      options: Options(
        headers: {'lang': getLan()},
      ),
    );

    CountriesMdoel countriesModel = CountriesMdoel.fromJson(response);
    countriesStreamController.sink.add(countriesModel.data!);
  }

  Future<void> saveLanguageToHive(BuildContext? context, localLanguage) async {
    await locator<HiveService>().setValue<String>(
        boxName: AppConstants.hiveBox,
        key: AppConstants.languageHiveKey,
        value: localLanguage!);
    if (context != null) MainApp.of(context)?.rebuild();
  }

  String getLan() {
    return locator<HiveService>().getValue(
            boxName: AppConstants.hiveBox, key: AppConstants.languageHiveKey) ??
        "en";
  }
}
