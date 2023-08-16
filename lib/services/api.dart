import 'package:countries_app/constants.dart';

import 'package:countries_app/services/exception_handler.dart';

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<T> apiRequest<T>(
      {required String path,
      dynamic body,
      required String method,
      Options? options}) async {
    try {
      Response response;

      if (method == 'GET') {
        response = await _dio.get(path, options: options);
      } else if (method == 'POST') {
        response = await _dio.post(path, data: body, options: options);
      } else {
        throw Exception('Unsupported HTTP method: $method');
      }

      if (response.statusCode == 200) {
        //return response.data;
        return response.data as T;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      HttpExceptionHandler.handleException(e);
      print(e);
      throw Exception(e.toString());
    }
  }
}
