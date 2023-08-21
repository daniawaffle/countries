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

  String? language =
      locator<HiveService>().getValue(boxName: hiveBox, key: languageHiveKey) ??
          "en";
  List<Country> countries = [];

  Future<List<Country>> getCountries() async {
    final responbse = await locator<ApiService>().apiRequest(
      path: "countries",
      method: getMethod,
      options: Options(
        headers: {'lang': language},
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
    language = localLanguage;

    await locator<HiveService>().setValue<String>(
        boxName: hiveBox, key: languageHiveKey, value: language!);
  }
}
