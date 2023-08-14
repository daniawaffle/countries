import 'package:flutter/material.dart';

class LoginBLoc {
  final formKey = GlobalKey<FormState>();

  TextEditingController numberController = TextEditingController();

  String dropdownvalue = '+962';
  var prefixNum = ['+962', '+963', '+318', '+11', '+113'];
}
