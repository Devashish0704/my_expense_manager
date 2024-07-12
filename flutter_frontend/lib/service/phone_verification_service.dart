import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/dio.dart';

class PhoneVerificationService {
  final Dio _dio = DioClient.dio;

  Future<String?> sendOtp(Map<String, String?> phoneNumber) async {
    try {
      final response = await _dio.post('/auth/generate-otp', data: phoneNumber);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        String reply = jsonResponse['message'];
        return reply;
      } else {
        throw Exception('Failed to Send OTP');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> verifyOtp(Map<String, String?> otp) async {
    try {
          print('Sending OTP data: $otp');

      final response = await _dio.post('/auth/verify-otp', data: otp);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        String reply = jsonResponse['message'];
        return reply;
      } else {
        throw Exception('Failed to Verify OTP');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
