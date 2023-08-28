import 'package:countries_app/services/exception_handler.dart';
import 'package:test/test.dart';
import 'package:dio/dio.dart'; // Import DioException if not already imported

void main() {
  test('handleException should return correct HttpResultStatus', () {
    // Test DioException with a response of status code 401
    final dioException401 = DioException(
        response: Response(statusCode: 401, requestOptions: RequestOptions()),
        requestOptions: RequestOptions());
    expect(HttpExceptionHandler.handleException(dioException401),
        HttpResultStatus.unauthorized);
    final dioException402 = DioException(
        response: Response(statusCode: 402, requestOptions: RequestOptions()),
        requestOptions: RequestOptions());
    expect(HttpExceptionHandler.handleException(dioException402),
        HttpResultStatus.unauthorized);
    final dioException403 = DioException(
        response: Response(statusCode: 403, requestOptions: RequestOptions()),
        requestOptions: RequestOptions());
    expect(HttpExceptionHandler.handleException(dioException403),
        HttpResultStatus.unauthorized);

    final dioException404 = DioException(
        response: Response(statusCode: 404, requestOptions: RequestOptions()),
        requestOptions: RequestOptions());
    expect(HttpExceptionHandler.handleException(dioException404),
        HttpResultStatus.notFound);
    final dioException429 = DioException(
        response: Response(statusCode: 429, requestOptions: RequestOptions()),
        requestOptions: RequestOptions());
    expect(HttpExceptionHandler.handleException(dioException429),
        HttpResultStatus.tooManyRequests);

    final dioException500 = DioException(
        response: Response(statusCode: 500, requestOptions: RequestOptions()),
        requestOptions: RequestOptions());
    expect(HttpExceptionHandler.handleException(dioException500),
        HttpResultStatus.serverError);
  });

  test('generateExceptionMessage should return correct error message', () {
    expect(
        HttpExceptionHandler.generateExceptionMessage(
            HttpResultStatus.unauthorized),
        "Unauthorized access.");
    expect(
        HttpExceptionHandler.generateExceptionMessage(
            HttpResultStatus.notFound),
        "Resource not found.");
    expect(
        HttpExceptionHandler.generateExceptionMessage(
            HttpResultStatus.tooManyRequests),
        "Too many requests. Try again later.");
    expect(
        HttpExceptionHandler.generateExceptionMessage(
            HttpResultStatus.serverError),
        "Server error. Try again later.");
  });
}
