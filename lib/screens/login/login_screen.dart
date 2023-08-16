import 'package:countries_app/constants.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/screens/verfication/verfication_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final Country country;
  final List<Country> countries;
  const LoginScreen(
      {super.key, required this.country, required this.countries});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  LoginBLoc loginBLoc = LoginBLoc();
  bool isDisabled = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    loginBLoc.selectedCountry = widget.country;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Adjust the duration as needed
    )..repeat();
  }

  _validateNumber(String value) {
    if (value.length != loginBLoc.selectedCountry.minLength) {
      return 'Please enter ${loginBLoc.selectedCountry.minLength} digits number';
    } else {
      setState(() {
        isDisabled = false;
      });
      return null;
    }
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
        backgroundColor: primaryColor,
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
                        value: loginBLoc.selectedCountry,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: widget.countries.map((Country country) {
                          return DropdownMenuItem<Country>(
                            value: country,
                            child: Text(country.dialCode!),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            loginBLoc.selectedCountry = newValue!;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 8,
                        child: Form(
                          key: loginBLoc.formKey,
                          child: TextFormField(
                            controller: loginBLoc.numberController,
                            maxLength: loginBLoc.selectedCountry.maxLength,
                            onChanged: (String value) {
                              _validateNumber(value);
                              loginBLoc.numberController.text = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2.0,
                                  )),
                              labelStyle: TextStyle(color: primaryColor),
                              labelText:
                                  AppLocalizations.of(context)!.enterNumText,
                              border: const OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                isDisabled
                    ? Container()
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor)),
                        onPressed: () async {
                          try {
                            var response = await loginBLoc.login(
                                countryId: loginBLoc.selectedCountry.id!,
                                phoneNumber:
                                    loginBLoc.selectedCountry.dialCode! +
                                        loginBLoc.numberController.text);

                            if (context.mounted) {
                              print('OTP  ${response.loginModel!.lastOtp}');

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationScreen(
                                    loginOTP: response.loginModel!.lastOtp!,
                                    countryId: loginBLoc.selectedCountry.id!,
                                    phoneNumber:
                                        loginBLoc.selectedCountry.dialCode! +
                                            loginBLoc.numberController.text,
                                    userId: response.loginModel!.id!,
                                  ),
                                ),
                              );
                            }
                          } catch (error) {
                            print(error);
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.nextText),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
