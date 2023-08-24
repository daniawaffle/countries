import 'dart:async';
import 'package:countries_app/locater.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/services/hive.dart';
import 'package:dio/dio.dart';
import '../../constants.dart';
import '../../services/api.dart';

class StartupBloc {
  StreamController<List<Country>> countriesStreamController =
      StreamController<List<Country>>();

  List<Country> countries = [];

  Future<List<Country>> getCountries() async {
    final responbse = await locator<ApiService>().apiRequest(
      path: "countries",
      method: AppConstants.getMethod,
      options: Options(
        headers: {'lang': getLan()},
      ),
    );

    CountriesMdoel countriesModel = CountriesMdoel.fromJson(responbse);
    if (countriesModel.data != null) {
      countries = countriesModel.data!;
    }
    countriesStreamController.sink.add(countries);
    return countries;
  }

  Future<void> saveLanguageToHive(localLanguage) async {
    await locator<HiveService>().setValue<String>(
        boxName: AppConstants.hiveBox,
        key: AppConstants.languageHiveKey,
        value: localLanguage!);
  }

  String getLan() {
    return locator<HiveService>().getValue(
            boxName: AppConstants.hiveBox, key: AppConstants.languageHiveKey) ??
        "en";
  }
}
