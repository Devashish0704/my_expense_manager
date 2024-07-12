import 'package:dio/dio.dart';

class DioClient {
  // Private static instance of Dio
  static final Dio _dio = Dio();

  // Getter to access the Dio instance
  static Dio get dio => _dio;

  // Setup method to configure the Dio instance
  static void setup() {
    _dio.options.baseUrl = 'https://my-expense-manager.onrender.com/api';
    _dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 5); // 5 seconds
  }
}
