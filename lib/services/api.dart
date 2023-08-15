import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/services/hive.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  List<Country> _countries = [];

  Future<List<Country>> getCountriesData() async {
    try {
      String language = locator<HiveService>()
          .getValue(boxName: languageHiveBox, key: languageHiveKey);
      var response = await _dio.get(
        'countries',
        options: Options(headers: {'lang': language}),
      );
      if (response.statusCode == 200) {
        final countriesModel = CountriesMdoel.fromJson(response.data);

        _countries = countriesModel.data!;
        return _countries;
        // return _countries;
      } else {
        print(response.statusMessage);
        return _countries;
      }
    } catch (e) {
      print(e);
      return _countries;
    }
  }
}
