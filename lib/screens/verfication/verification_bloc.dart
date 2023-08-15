import 'package:otp_text_field/otp_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class VerificationBloc {
  OtpFieldController otpController = OtpFieldController();

  OtpTimerButtonController resendController = OtpTimerButtonController();

  requestOtp() {
    resendController.loading();
    Future.delayed(const Duration(seconds: 2), () {
      resendController.startTimer();
    });
  }

  bool isLoading = false;

  Future<void> login() async {
    isLoading = true;
  }
}
