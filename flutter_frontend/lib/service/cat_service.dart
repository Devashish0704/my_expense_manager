import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/dio.dart';
import 'auth_service.dart';

class CategoryService {
  final Dio _dio = DioClient.dio;

  static Map<int, String> expenseCategories = {};
  static Map<int, String> incomeCategories = {};
  static Map<int, String> expenseCategoriesCanBeDeleted = {};
  static Map<int, String> incomeCategoriesCanBeDeleted = {};

  Future<void> fetchAndSetCategories(int? userId) async {
    try {
      final response = await _dio.get('/categories/$userId',
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        expenseCategories = _convertToIntStringMap(data['expenseCategories']);
        print(expenseCategories);
        incomeCategories = _convertToIntStringMap(data['incomeCategories']);
        print(incomeCategories);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<void> fetchAndSetCategoriesForDeletion(int? userId) async {
    try {
      final response = await _dio.get('/categories/deletion/$userId',
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        expenseCategoriesCanBeDeleted =
            _convertToIntStringMap(data['expenseCategories']);
        print(expenseCategoriesCanBeDeleted);
        incomeCategoriesCanBeDeleted =
            _convertToIntStringMap(data['incomeCategories']);
        print(incomeCategoriesCanBeDeleted);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<String?> addExpenseCategoryByUser(
      Map<String, String> addExpenseCategory) async {
    try {
      final response = await _dio.post('/categories',
          data: addExpenseCategory,
          options: Options(
              headers: {'Authorization': 'Bearer ${AuthService().token}'}));
      if (response.statusCode == 201) {
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print('Adding Expense Category error $e');
    }
    return null;
  }

  Future<String?> deleteCategory(int categoryID) async {
    try {
      final response = await _dio.delete(
        '/categories/$categoryID',
        // data: {'id': categoryID},
        options: Options(
            headers: {'Authorization': 'Bearer ${AuthService().token}'}),
      );
      if (response.statusCode == 200) {
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print(
          'Exception occurred while deleting category: $e'); // Debug statement
    }
    return null;
  }

  Map<int, String> _convertToIntStringMap(Map<dynamic, dynamic> map) {
    return map.map(
        (key, value) => MapEntry(int.parse(key.toString()), value.toString()));
  }
}
