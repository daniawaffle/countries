import 'package:countries_app/screens/main_container/main_container.dart';
import 'package:countries_app/screens/verfication/verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants.dart';

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
  VerificationBloc bloc = VerificationBloc();

  // String otpp = '';
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
              const SizedBox(height: 20),
              Directionality(
                textDirection: TextDirection.ltr,
                child: OTPTextField(
                    controller: bloc.otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.center,
                    fieldWidth: 50,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 2,
                    style: const TextStyle(fontSize: 17),
                    onChanged: (pin) {},
                    onCompleted: (pin) {
                      bloc.enteredOTP = pin;
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppConstants.primaryColor)),
                onPressed: () async {
                  var response = await bloc.verify(
                      phoneNumber: widget.phoneNumber,
                      countryId: widget.countryId,
                      userId: widget.userId,
                      lastOTP: bloc.enteredOTP);
                  if (context.mounted &&
                      response != null &&
                      response.verifyModel != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainContainer(),
                        ));
                  }
                },
                child: Text(AppLocalizations.of(context)!.loginText),
              ),
              ValueListenableBuilder(
                valueListenable: bloc.otpButtonVisible,
                builder: (context, isVisible, child) {
                  return isVisible
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppConstants.primaryColor)),
                          onPressed: () {
                            bloc.sendOtp(widget.phoneNumber, widget.countryId);
                          },
                          child:
                              Text(AppLocalizations.of(context)!.resendOtpText),
                        )
                      : ValueListenableBuilder(
                          valueListenable: bloc.currentSeconds,
                          builder: (BuildContext context, int counterValue,
                              Widget? child) {
                            return Text(
                              bloc.timerText,
                              style: const TextStyle(fontSize: 15),
                            );
                          });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
