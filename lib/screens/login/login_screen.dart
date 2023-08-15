import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/screens/verfication/verfication_screen.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final Country country;
  const LoginScreen({super.key, required this.country});

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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Adjust the duration as needed
    )..repeat();
  }

  _validateNumber(String value) {
    if (value.length != widget.country.minLength) {
      return 'Please enter 9 digits number';
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
      appBar: AppBar(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // DropdownButton(
                    //   value: _selectedDialCode,
                    //   icon: const Icon(Icons.keyboard_arrow_down),
                    //   items: _countries.map((Data country) {
                    //     return DropdownMenuItem<String>(
                    //       value: country.dialCode,
                    //       child: Text(country.dialCode!),
                    //     );
                    //   }).toList(),
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       _selectedDialCode = newValue!;
                    //     });
                    //   },
                    // ),
                    Text(widget.country.dialCode!),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 8,
                      child: Form(
                        key: loginBLoc.formKey,
                        child: TextFormField(
                          controller: loginBLoc.numberController,
                          maxLength: widget.country.maxLength,
                          onChanged: (String value) {
                            _validateNumber(value);
                            loginBLoc.numberController.text = value;
                          },
                          decoration: const InputDecoration(
                            labelText: "Enter your number",
                            border: OutlineInputBorder(),
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
                const SizedBox(height: 24),
                isDisabled
                    ? Container()
                    : ElevatedButton(
                        onPressed: () async {
                          try {
                            Response response = await loginBLoc.login(
                                countryId: widget.country.id!,
                                phoneNumber: widget.country.dialCode! +
                                    loginBLoc.numberController.text);

                            if (context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationScreen(
                                      loginOTP: response.data['data']
                                          ['last_otp'],
                                      countryId: widget.country.id!,
                                      phoneNumber: widget.country.dialCode! +
                                          loginBLoc.numberController.text,
                                      userId: 1 //response.data['data']['id'],
                                      ),
                                ),
                              );
                            }
                          } catch (error) {
                            print(error);
                          }
                        },
                        child: const Text('Next'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
