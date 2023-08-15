import 'package:countries_app/screens/verfication/verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final int userId;
  final int countryId;
  final String loginOTP;

  const VerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.userId,
    required this.countryId,
    required this.loginOTP,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  VerificationBloc verBloc = VerificationBloc();
  String otpp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/globe.png',
                fit: BoxFit.fitWidth,
                height: 50,
                width: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              OTPTextField(
                  controller: verBloc.otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.center,
                  fieldWidth: 50,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 2,
                  style: const TextStyle(fontSize: 17),
                  onChanged: (pin) {},
                  onCompleted: (pin) {
                    print("Completed: " + pin);

                    otpp = pin;
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  verBloc.verify(
                      phoneNumber: widget.phoneNumber,
                      countryId: widget.countryId,
                      userId: widget.userId,
                      lastOTP: otpp);
                },
                child: const Text('Login'),
              ),
              OtpTimerButton(
                controller: verBloc.resendController,
                onPressed: () => verBloc.requestNewOtp(
                    phoneNumber: widget.phoneNumber,
                    countryId: widget.countryId),
                text: const Text('Resend OTP'),
                duration: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
