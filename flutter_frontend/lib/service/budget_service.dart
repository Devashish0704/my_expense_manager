import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/dio.dart';

class BudgetService {
  final Dio _dio = DioClient.dio;

  Future<List<Map<String, dynamic>>?> checkBudgets(int? userId) async {
    try {
      final response = await _dio.get('/budgets/check/$userId',
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load Budgets');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> addBudget(
      Map<String, String> addBudgetData) async {
    try {
      final response = await _dio.post('/budgets',
          data: addBudgetData,
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

  Future<String?> deleteBudget(int? budgetId) async {
    try {
      final response = await _dio.delete('/budgets/$budgetId',
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
