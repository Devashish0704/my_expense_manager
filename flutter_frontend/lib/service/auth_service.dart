// auth_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/dio.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final Dio _dio = DioClient.dio;
  int? userID;
  String? token;

  Future<String?> login(Map<String, String> loginData) async {
    try {
      final response =
          await _dio.post('/login', data: loginData);
      if (response.statusCode == 200) {
        userID = response.data['id'];
        token = response.data['token'];
        print('UserID after login: $userID');
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<String?> signup(Map<String, String> signUpData) async {
    try {
      final response =
          await _dio.post('/register', data: signUpData);
      if (response.statusCode == 201) {
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print('Sign up error: $e');
    }
    return null;
  }
}


  