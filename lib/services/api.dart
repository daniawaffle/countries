import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/services/exception_handler.dart';
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
      HttpExceptionHandler.handleException(e);
      print(e);
      return _countries;
    }
  }

  Future sendOtpRequest(
      {required String phoneNumber, required int countryId}) async {
    final response = await _dio.post(
      'client-auth-debug',
      data: {
        'mobile_number': phoneNumber,
        'os_type': 'iOS',
        'country_id': countryId,
        'device_type_name': 'iPhone 6',
        'os_version': '16.1',
        'app_version': '1.0',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.data['data'];
      final lastOtp = responseData['last_otp'];
      print(response);
      print('Last OTP: $lastOtp');
    } else {
      print(response.statusCode);
    }
    return response;
  }

  Future<void> verifyUser(
      {required String phoneNumber,
      required int countryId,
      required int userId,
      required String lastOTP}) async {
    print('$lastOTP 3nd el verify');
    final response = await _dio.post(
      'client-auth-verify',
      data: {
        "mobile_number": phoneNumber,
        "user_id": userId,
        "os_type": "iOS",
        "country_id": countryId,
        "device_type_name": "iPhone",
        "os_version": "16.0",
        "app_version": "1.0.0",
        "otp": lastOTP,
        "api_key": "00101"
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.data['data'];
      final lastOtp = responseData['last_otp'];
      print(response);
      print('Last OTP: $lastOtp'); // Print the last_otp value
    } else {
      print(response.statusCode);
    }
  }
}
