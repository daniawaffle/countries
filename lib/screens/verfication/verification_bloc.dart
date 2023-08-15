import 'package:otp_text_field/otp_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../../services/api.dart';

class VerificationBloc {
  OtpFieldController otpController = OtpFieldController();

  OtpTimerButtonController resendController = OtpTimerButtonController();
  final ApiService apiService = ApiService();

  requestNewOtp({
    required String phoneNumber,
    required int countryId,
  }) {
    resendController.loading();
    Future.delayed(const Duration(seconds: 2), () {
      resendController.startTimer();
    });
    apiService.sendOtpRequest(phoneNumber: phoneNumber, countryId: countryId);
  }

  bool isLoading = false;

  Future<void> login() async {
    isLoading = true;
  }

  Future<void> verify(
      {required String phoneNumber,
      required int countryId,
      required int userId,
      required String lastOTP}) async {
    await apiService.verifyUser(
        phoneNumber: phoneNumber,
        countryId: countryId,
        userId: userId,
        lastOTP: lastOTP);
  }
}
