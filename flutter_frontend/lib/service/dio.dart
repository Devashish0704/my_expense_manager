import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  static void setup() {
    _dio.options.baseUrl = 'https://my-expense-manager.onrender.com/api';
    _dio.options.connectTimeout = const Duration(seconds: 52); 
    _dio.options.receiveTimeout = const Duration(seconds: 52); 

  }
}


// https://my-expense-manager.onrender.com/api
// http://localhost:3000/api