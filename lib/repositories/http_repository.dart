import 'package:dio/dio.dart';

class DataRepository {
  final Dio _dio;

  DataRepository(this._dio);

  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await _dio.get('https://www.helpera.app/countries');
      return response.data;
    } catch (error) {
      rethrow;
    }
  }
}
