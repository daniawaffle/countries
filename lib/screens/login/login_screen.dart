import 'package:countries_app/constants.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/screens/verfication/verfication_screen.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final Country selectedCountry;
  final List<Country> listOfCountries;
  const LoginScreen({super.key, required this.selectedCountry, required this.listOfCountries});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  LoginBLoc bloc = LoginBLoc();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    bloc.selectedCountry = widget.selectedCountry;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: _controller,
                  child: Image.asset(
                    'assets/globe.png',
                    fit: BoxFit.fitWidth,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 40),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: bloc.selectedCountry,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: widget.listOfCountries.map((Country country) {
                          return DropdownMenuItem<Country>(
                            value: country,
                            child: Text(country.dialCode!),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            bloc.selectedCountry = newValue!;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      ValueListenableBuilder<String?>(
                        valueListenable: bloc.errorMessage,
                        builder: (context, errorMessageValue, child) {
                          return Expanded(
                            flex: 8,
                            child: Form(
                              key: bloc.formKey,
                              child: TextFormField(
                                controller: bloc.numberController,
                                maxLength: bloc.selectedCountry!.maxLength,
                                onChanged: (String value) {
                                  bloc.validateNumber(
                                    value,
                                    bloc.selectedCountry!.minLength!,
                                  );
                                  bloc.numberController.text = value;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: AppConstants.primaryColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: AppConstants.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  labelStyle: TextStyle(color: AppConstants.primaryColor),
                                  labelText: AppLocalizations.of(context)!.enterNumText,
                                  border: const OutlineInputBorder(),
                                  errorText: errorMessageValue,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder<bool?>(
                    valueListenable: bloc.showButtonNotifer,
                    builder: (context, snapshot, child) {
                      return snapshot!
                          ? Container()
                          : ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppConstants.primaryColor)),
                              onPressed: () async {
                                try {
                                  var response = await bloc.login(
                                      countryId: bloc.selectedCountry!.id!,
                                      phoneNumber: bloc.selectedCountry!.dialCode! + bloc.numberController.text);

                                  if (context.mounted) {
                                    if (kDebugMode) {
                                      print('OTP  ${response.loginModel!.lastOtp}');
                                    }

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VerificationScreen(
                                          loginOTP: response.loginModel!.lastOtp!,
                                          countryId: bloc.selectedCountry!.id!,
                                          phoneNumber: bloc.selectedCountry!.dialCode! + bloc.numberController.text,
                                          userId: response.loginModel!.id!,
                                        ),
                                      ),
                                    );
                                  }
                                } catch (error) {
                                  if (kDebugMode) {
                                    print(error);
                                  }
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.nextText,
                              ),
                            );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
