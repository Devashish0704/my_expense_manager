// auth_service.dart

import 'package:flutter_frontend/service/config.dart';
import 'package:dio/dio.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final Dio _dio = Dio();
  int? userID;
  String? token;
  List<Map<String, dynamic>>? expenses;

  Future<String?> login(Map<String, String> loginData) async {
    try {
      final response =
          await _dio.post('${ApiConfig.baseUrl}/login', data: loginData);
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
          await _dio.post('${ApiConfig.baseUrl}/register', data: signUpData);
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

  Future<List<Map<String, dynamic>>?> getExpensesOfUser(int? userId) async {
    try {
      final response = await _dio.get('${ApiConfig.baseUrl}/expenses/$userId',
          options:
              Options(headers: {'Authorization': 'Bearer ${_instance.token}'}));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        expenses = data.map((item) => item as Map<String, dynamic>).toList();
        // List<String> categoryIds = [];
        // if (expenses != null) {
        //   for (var expense in expenses!) {
        //     if (expense.containsKey('category_id')) {
        //       categoryIds.add(expense['category_id'].toString());
        //     }
        //   }
        // }
        // print(categoryIds);

        return expenses;
      } else {
        throw Exception('Failed to load expenses');
      }
    } catch (e) {
      print('Fetching expense error: $e');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getIncomeOfUser(int? userId) async {
    try {
      final response = await _dio.get('${ApiConfig.baseUrl}/income/$userId',
          options:
              Options(headers: {'Authorization': 'Bearer ${_instance.token}'}));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load expenses');
      }
    } catch (e) {
      print('Fetching Income error: $e');
    }
    return null;
  }

  Future<String?> addExpenseOfUser(Map<String, String> addExpense) async {
    try {
      final response = await _dio.post('${ApiConfig.baseUrl}/expenses',
          data: addExpense,
          options:
              Options(headers: {'Authorization': 'Bearer ${_instance.token}'}));
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

  Future<String?> addIncomeOfUser(Map<String, String> addIncome) async {
    try {
      final response = await _dio.post('${ApiConfig.baseUrl}/income',
          data: addIncome,
          options:
              Options(headers: {'Authorization': 'Bearer ${_instance.token}'}));
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

  Future<String?> deleteExpenseOfUser(int? userId, int expenseId) async {
    try {
      final response = await _dio.delete(
        '${ApiConfig.baseUrl}/expenses/$userId',
        data: {'expense_id': expenseId},
        options:
            Options(headers: {'Authorization': 'Bearer ${_instance.token}'}),
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

  Future<String?> deleteIncomeOfUser(int? userId, int incomeId) async {
    try {
      final response = await _dio.delete(
        '${ApiConfig.baseUrl}/income/$userId',
        data: {'income_id': incomeId},
        options:
            Options(headers: {'Authorization': 'Bearer ${_instance.token}'}),
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
