import 'package:countries_app/screens/verfication/verfication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBLoc loginBLoc = LoginBLoc();
  bool isDisabled = true;

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
              Row(
                children: [
                  DropdownButton(
                    value: loginBLoc.dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: loginBLoc.prefixNum.map((String num) {
                      return DropdownMenuItem(
                        value: num,
                        child: Text(num),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        loginBLoc.dropdownvalue = newValue!;
                      });
                    },
                  ),
                  Expanded(
                    child: Form(
                      key: loginBLoc.formKey,
                      child: TextFormField(
                        maxLength: 9,
                        onChanged: (String value) {
                          _validateNumber(value);
                        },
                        decoration: const InputDecoration(
                            labelText: "Enter your number"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              isDisabled
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VerificationScreen()),
                        );
                      },
                      child: const Text('Next'))
            ],
          ),
        ),
      ),
    );
  }
}
