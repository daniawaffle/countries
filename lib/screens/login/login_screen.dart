import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/screens/verfication/verfication_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required Country country, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  LoginBLoc loginBLoc = LoginBLoc();
  bool isDisabled = true;
  late AnimationController _controller;

  final Dio _dio = Dio();
  List<Data> _countries = [];
  String? _selectedDialCode;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Adjust the duration as needed
    )..repeat();

    fetchData();
  }

  _validateNumber(String value) {
    if (value.length != 9) {
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

  Future<void> sendOtpRequest() async {
    try {
      final response = await _dio.post(
        'https://www.helpera.app/client-auth-debug',
        data: {
          'mobile_number': '00962795190663',
          'os_type': 'iOS',
          'country_id': 1,
          'device_type_name': 'iPhone 6',
          'os_version': '16.1',
          'app_version': '1.0',
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data['data'];
        final lastOtp = responseData['last_otp'];
        print('Last OTP: $lastOtp'); // Print the last_otp value
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              lastOTP: lastOtp,
            ),
          ),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  List dialCode = [];
  Future<void> fetchData() async {
    try {
      var response = await _dio.get(
        'https://www.helpera.app/countries',
        options: Options(headers: {'lang': 'en'}),
      );
      if (response.statusCode == 200) {
        final countriesModel = CountriesModel.fromJson(response.data);
        _countries = countriesModel.data!;
        // Print dialCode for each country
        _countries.forEach((country) {
          print(country.dialCode);
          dialCode.add(country.dialCode);
        });
        setState(() {
          _selectedDialCode =
              _countries.isNotEmpty ? _countries[0].dialCode : null;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    DropdownButton(
                      value: _selectedDialCode,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _countries.map((Data country) {
                        return DropdownMenuItem<String>(
                          value: country.dialCode,
                          child: Text(country.dialCode!),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDialCode = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 8,
                      child: Form(
                        key: loginBLoc.formKey,
                        child: TextFormField(
                          maxLength: 9,
                          onChanged: (String value) {
                            _validateNumber(value);
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
                        onPressed: sendOtpRequest,
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
