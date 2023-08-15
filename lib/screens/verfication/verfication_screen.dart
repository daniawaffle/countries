import 'dart:ffi';

import 'package:countries_app/screens/verfication/verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class VerificationScreen extends StatefulWidget {
  final lastOTP;
  const VerificationScreen({super.key, required this.lastOTP});

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
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);

                    otpp = pin;
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.lastOTP == otpp) {
                    print('Login success');
                  } else {
                    print('login Failed');
                    print(widget.lastOTP);
                    print(verBloc.otpController);
                  }
                },
                child: const Text('Login'),
              ),
              OtpTimerButton(
                controller: verBloc.resendController,
                onPressed: () => verBloc.requestOtp(),
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
