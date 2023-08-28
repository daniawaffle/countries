import 'package:countries_app/constants.dart';
import 'package:countries_app/utils/exception_handler.dart';

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<dynamic> apiRequest(
      {required String path,
      dynamic body,
      required String method,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response;

      if (method == AppConstants.getMethod) {
        response = await _dio.get(path, options: options, queryParameters: queryParameters);
      } else if (method == AppConstants.postMethod) {
        response = await _dio.post(path, data: body, options: options, queryParameters: queryParameters);
      } else {
        throw Exception('Unsupported HTTP method: $method');
      }

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      var tt = HttpExceptionHandler.handleException(e);
      throw Exception(HttpExceptionHandler.generateExceptionMessage(tt));
    }
  }
}
