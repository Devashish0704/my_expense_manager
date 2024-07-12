import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/dio.dart';

class RegularPaymentService {
  final Dio _dio = DioClient.dio;

  Future<List<Map<String, dynamic>>?> getRegularPayments(int? userId) async {
    try {
      final response = await _dio.get('/recurring-txns/$userId',
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load Regular Payments');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> addRegularPayments(
      Map<String, String> addRegularPaymentData) async {
    try {
      final response = await _dio.post('/recurring-txns',
          data: addRegularPaymentData,
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 201) {
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> deleteRegularPayments(int? regPayId) async {
    try {
      final response = await _dio.delete('/recurring-txns/$regPayId',
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 200) {
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
