import 'package:countries_app/locater.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/services/hive.dart';

import '../../constants.dart';
import '../../services/api.dart';

class StartupBloc {
  String? language = locator<HiveService>()
          .getValue(boxName: languageHiveBox, key: languageHiveKey) ??
      "English";
  List<Country> countries = [];

  Future<void> getCountries() async {
    countries = await locator<ApiService>().getCountriesData();
  }
}
