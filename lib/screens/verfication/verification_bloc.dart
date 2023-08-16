import 'package:countries_app/models/verify_model.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../../locater.dart';
import '../../models/login_model.dart';
import '../../services/api.dart';

class VerificationBloc {
  OtpFieldController otpController = OtpFieldController();

  OtpTimerButtonController resendController = OtpTimerButtonController();
  final ApiService apiService = ApiService();

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

    final response =
        await locator<ApiService>().apiRequest<Map<String, dynamic>>(
      path: "client-auth-debug",
      method: 'POST',
      body: body,
    );

    resendController.loading();
    Future.delayed(const Duration(seconds: 2), () {
      resendController.startTimer();
    });

    print(LoginApiModel.fromJson(response).loginModel!.lastOtp);
    return LoginApiModel.fromJson(response);
  }

  bool isLoading = false;

  Future<void> login() async {
    isLoading = true;
  }

  Future<VerifyApiModel> verify(
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

    final response =
        await locator<ApiService>().apiRequest<Map<String, dynamic>>(
      path: "client-auth-verify",
      method: 'POST',
      body: body,
    );
    print(VerifyApiModel.fromJson(response).message);
    return VerifyApiModel.fromJson(response);
  }
}
