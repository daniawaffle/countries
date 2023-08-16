import 'package:countries_app/services/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginBLoc {
  final formKey = GlobalKey<FormState>();

  final ApiService apiService = ApiService();

  TextEditingController numberController = TextEditingController();

  Future login({required String phoneNumber, required int countryId}) async {
    Response response = await apiService.sendOtpRequest(
        phoneNumber: phoneNumber, countryId: countryId);
    return response;
  }
}
