import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/dio.dart';
import 'auth_service.dart';

class ExpenseService {
  final Dio _dio = DioClient.dio;
  List<Map<String, dynamic>>? expenses;

  Future<List<Map<String, dynamic>>?> getExpensesOfUser(int? userId) async {
    try {
      final response = await _dio.get('/expenses/$userId',
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        expenses = data.map((item) => item as Map<String, dynamic>).toList();
        return expenses;
      } else {
        throw Exception('Failed to load expenses');
      }
    } catch (e) {
      print('Fetching expense error: $e');
    }
    return null;
  }

  Future<String?> addExpenseOfUser(Map<String, String> addExpense) async {
    try {
      final response = await _dio.post('/expenses',
          data: addExpense,
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 201) {
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print('Adding expense error: $e');
    }
    return null;
  }

  Future<String?> deleteExpenseOfUser(int? userId, int expenseId) async {
    try {
      final response = await _dio.delete(
        '/expenses/$userId',
        data: {'expense_id': expenseId},
        options: Options(
            headers: {'Authorization': 'Bearer ${AuthService().token}'}),
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
