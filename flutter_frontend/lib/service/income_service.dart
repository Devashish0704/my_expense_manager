import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/dio.dart';
import 'auth_service.dart';

class IncomeService {
  final Dio _dio = DioClient.dio;

  Future<List<Map<String, dynamic>>?> getIncomeOfUser(int? userId) async {
    try {
      final response = await _dio.get('/income/$userId',
          options: Options(headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load income');
      }
    } catch (e) {
      print('Fetching Income error: $e');
    }
    return null;
  }

  Future<String?> addIncomeOfUser(Map<String, String> addIncome) async {
    try {
      final response = await _dio.post('/income',
          data: addIncome,
          options: Options(headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 201) {
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print('Adding income error: $e');
    }
    return null;
  }

  Future<String?> deleteIncomeOfUser(int? userId, int incomeId) async {
    try {
      final response = await _dio.delete(
        '/income/$userId',
        data: {'user_id': incomeId},
        options: Options(headers: {'Authorization': 'Bearer ${AuthService().token}'}),
      );
      if (response.statusCode == 200) {
        return response.statusMessage;
      } else {
        throw Exception('Failed to delete');
      }
    } catch (e) {
      print('deletion error: $e');
    }
    return null;
  }
}
