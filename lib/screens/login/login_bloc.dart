import 'package:countries_app/constants.dart';
import 'package:countries_app/services/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../locater.dart';

class LoginBLoc {
  final formKey = GlobalKey<FormState>();
  String? selectedDialCode;

  TextEditingController numberController = TextEditingController();

  Future login({required String phoneNumber, required int countryId}) async {
    // Response response = await apiService.sendOtpRequest(
    //     phoneNumber: phoneNumber, countryId: countryId);
    Map body = {
      'mobile_number': phoneNumber,
      'os_type': 'iOS',
      'country_id': countryId,
      'device_type_name': 'iPhone 6',
      'os_version': '16.1',
      'app_version': '1.0',
    };
    Response response = await locator<ApiService>()
        .apiRequest(path: "client-auth-debug", method: postMethod, body: body);
    return response;
  }
}
