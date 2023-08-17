import 'dart:async';

import 'package:countries_app/screens/verfication/verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants.dart';
import '../equiti/equiti_academy_screen.dart';

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

  void startTimeout() {
    var duration = verBloc.interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        verBloc.currentSeconds = timer.tick;
        if (timer.tick >= verBloc.timerMaxSeconds) {
          timer.cancel();
          verBloc.otpButtonVisible.value = true;
        }
      });
    });
  }

  void sendOtp() {
    verBloc.requestNewOtp(
        phoneNumber: widget.phoneNumber, countryId: widget.countryId);
    verBloc.otpButtonVisible.value = false; // Hide the button
    verBloc.currentSeconds = 0; // Reset timer
    startTimeout(); // Start timer
  }

  @override
  void initState() {
    super.initState();
  }

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
              Directionality(
                textDirection: TextDirection.ltr,
                child: OTPTextField(
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
                      print("Completed: $pin");

                      otpp = pin;
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
                onPressed: () {
                  verBloc.verify(
                      phoneNumber: widget.phoneNumber,
                      countryId: widget.countryId,
                      userId: widget.userId,
                      lastOTP: otpp);
                  if (context.mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EquitiAcademyScreen(),
                        ));
                  }
                },
                child: Text(AppLocalizations.of(context)!.loginText),
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     // verBloc.requestNewOtp(
              //     //     phoneNumber: widget.phoneNumber,
              //     //     countryId: widget.countryId);
              //     setState(() {
              //       startTimeout();
              //     });
              //   },
              //   child: Text(timerText != 0
              //       ? '${AppLocalizations.of(context)!.resendOtpText}'
              //       : '${timerText}'),
              // ),

              ValueListenableBuilder(
                valueListenable: verBloc.otpButtonVisible,
                builder: (context, isVisible, child) {
                  return isVisible
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor)),
                          onPressed: sendOtp,
                          child:
                              Text(AppLocalizations.of(context)!.resendOtpText),
                        )
                      : Text(
                          verBloc.timerText,
                          style: TextStyle(fontSize: 15),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
