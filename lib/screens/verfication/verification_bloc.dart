import 'dart:async';

import 'package:countries_app/constants.dart';
import 'package:countries_app/models/verify_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../locater.dart';
import '../../models/login_model.dart';
import '../../services/api.dart';
import '../../services/hive.dart';

class VerificationBloc {
  final otpButtonVisible = ValueNotifier<bool>(true);
  final currentSeconds = ValueNotifier<int>(60);

  OtpFieldController otpController = OtpFieldController();

  String enteredOTP = "";

  final ApiService apiService = ApiService();
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 120;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds.value) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds.value) % 60).toString().padLeft(2, '0')}';

  void sendOtp(String phoneNumber, int countryId) async {
    requestNewOtp(phoneNumber: phoneNumber, countryId: countryId);

    otpButtonVisible.value = false;
    currentSeconds.value = 0;
    startTimeout();
  }

  void startTimeout() {
    final duration = interval;
    Timer.periodic(duration, (timer) {
      currentSeconds.value = timer.tick;
      if (timer.tick >= timerMaxSeconds) {
        timer.cancel();
        otpButtonVisible.value = true;
      }
    });
  }

  Future<LoginApiModel> requestNewOtp({
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

    final response = await locator<ApiService>().apiRequest(
      path: AppConstants.authMethod,
      method: AppConstants.postMethod,
      body: body,
    );
    if (kDebugMode) {
      print('OTP  ${LoginApiModel.fromJson(response).loginModel!.lastOtp}');
    }
    return LoginApiModel.fromJson(response);
  }

  Future<VerifyApiModel?> verify(
      {required String phoneNumber,
      required int countryId,
      required int userId,
      required String lastOTP}) async {
    Map<String, dynamic> body = {
      "mobile_number": phoneNumber,
      "user_id": userId,
      "os_type": "iOS",
      "country_id": countryId,
      "device_type_name": "iPhone",
      "os_version": "16.0",
      "app_version": "1.0.0",
      "otp": lastOTP,
      "api_key": "00101"
    };

    final response = await locator<ApiService>().apiRequest(
      path: AppConstants.authVerifyMethod,
      method: AppConstants.postMethod,
      body: body,
    );
    if (response == null) {
      Fluttertoast.showToast(
          msg: "Wrong OTP",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppConstants.primaryColor,
          textColor: Colors.white);
      return null;
    } else {
      locator<HiveService>().setValue(
          boxName: AppConstants.hiveBox,
          key: AppConstants.userTokenKey,
          value: VerifyApiModel.fromJson(response).verifyModel!.token);

      return VerifyApiModel.fromJson(response);
    }
  }
}
