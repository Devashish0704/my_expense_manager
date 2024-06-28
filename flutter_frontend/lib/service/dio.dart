import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  static void setup() {
    _dio.options.baseUrl = 'http://localhost:3000/api';
    _dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 5); // 5 seconds
  }
}
