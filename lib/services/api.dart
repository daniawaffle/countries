import 'package:countries_app/constants.dart';

import 'package:countries_app/services/exception_handler.dart';

import 'package:dio/dio.dart';

import 'interceptor.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(HttpInterciptor());

  Future<T> apiRequest<T>(
      {required String path,
      dynamic body,
      required String method,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response;

      if (method == 'GET') {
        response = await _dio.get(path,
            options: options, queryParameters: queryParameters);
      } else if (method == 'POST') {
        response = await _dio.post(path,
            data: body, options: options, queryParameters: queryParameters);
      } else {
        throw Exception('Unsupported HTTP method: $method');
      }

      if (response.statusCode == 200) {
        //return response.data;
        return response.data as T;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      var tt = HttpExceptionHandler.handleException(e);
      throw Exception(HttpExceptionHandler.generateExceptionMessage(tt));
    }
  }
}
