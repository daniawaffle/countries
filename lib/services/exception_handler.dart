import 'package:dio/dio.dart';

enum HttpResultStatus {
  successful,
  unauthorized,
  notFound,
  tooManyRequests,
  serverError,
  undefined,
}

class HttpExceptionHandler {
  static HttpResultStatus handleException(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      print(response!.statusCode);

      switch (response.statusCode) {
        case 401:
        case 402:
        case 403:
          return HttpResultStatus.unauthorized;
        case 404:
          return HttpResultStatus.notFound;
        case 429:
          return HttpResultStatus.tooManyRequests;
        case 500:
          return HttpResultStatus.serverError;
        default:
          return HttpResultStatus.undefined;
      }
    }
    return HttpResultStatus.undefined;
  }

  static String generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case HttpResultStatus.unauthorized:
        errorMessage = "Unauthorized access.";
        break;
      case HttpResultStatus.notFound:
        errorMessage = "Resource not found.";
        break;
      case HttpResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;

      default:
        errorMessage = "An undefined error happened.";
    }

    return errorMessage;
  }
}
