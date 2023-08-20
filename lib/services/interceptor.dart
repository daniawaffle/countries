import 'package:dio/dio.dart';

class HttpInterciptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // handler.next(err);
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // handler.next(response);
    super.onResponse(response, handler);
  }
}
