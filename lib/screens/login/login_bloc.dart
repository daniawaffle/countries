import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/models/login_model.dart';
import 'package:countries_app/services/api.dart';

import 'package:flutter/material.dart';

import '../../locater.dart';

class LoginBLoc {
  final formKey = GlobalKey<FormState>();

  late Country selectedCountry;

  ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  ValueNotifier<bool?> isDisabled = ValueNotifier<bool?>(true);

  TextEditingController numberController = TextEditingController();

  validateNumber(String value, int minLen) {
    if (value.length != minLen) {
      return 'Please enter $minLen digits number';
    } else {
      isDisabled.value = false;

      return null;
    }
  }

  Future<LoginApiModel> login({
    required String phoneNumber,
    required int countryId,
  }) async {
    Map<String, dynamic> body = {
      'mobile_number': phoneNumber,
      'os_type': 'iOS',
      'country_id': countryId,
      'device_type_name': 'iPhone 6',
      'os_version': '16.1',
      'app_version': '1.0',
    };

    final response =
        await locator<ApiService>().apiRequest<Map<String, dynamic>>(
      path: "client-auth-debug",
      method: 'POST',
      body: body,
    );

    return LoginApiModel.fromJson(response);
  }
}
