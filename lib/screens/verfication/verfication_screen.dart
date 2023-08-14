import 'dart:ffi';

import 'package:countries_app/screens/verfication/verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  VerificationBloc verBloc = VerificationBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/earth_logo.jpeg',
                fit: BoxFit.fitWidth,
                height: 175,
                width: 175,
              ),
              OTPTextField(
                  controller: verBloc.otpController,
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.center,
                  fieldWidth: 50,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 2,
                  style: const TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  }),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Next')),
              OtpTimerButton(
                controller: verBloc.resendController,
                onPressed: () => verBloc.requestOtp(),
                text: Text('Resend OTP'),
                duration: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
