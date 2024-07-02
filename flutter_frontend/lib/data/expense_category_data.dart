import 'package:flutter/material.dart';

Map<int, String> expenseCategories = {
  1: 'General',
  2: 'Food',
  3: 'Transport',
  4: 'Utilities',
  5: 'Entertainment',
  6: 'Shopping',
  7: 'Communication',
  8: 'Health',
  9: 'Education',
  10: 'Beauty',
  11: 'Clothing',
  12: 'Automobile',
  13: 'Liquor',
  14: 'Cigarette',
  15: 'Repair',
  16: 'Donate',
  17: 'Other'
};


Map<String, Color> categoryColors = {
  'Category': Colors.orange,
  'Food': Colors.red,
  'Transport': Colors.green,
  'Entertainment': Colors.blue,
  'Utilities': Colors.yellow,
  'Shopping': Colors.purple,
  'Telephone': Colors.pink,
  'Education': Colors.teal,
  'Beauty': Colors.cyan,
  'Clothing': Colors.lime,
  'Car': Colors.indigo,
  'Liquor': Colors.brown,
  'Cigarette': Colors.amber,
  'Repair': Colors.grey,
  'Donate': Colors.deepPurple,
  'Other': Colors.deepOrange,
};



Map<int, String> incomeCategories = {
  1: 'General',
  2: 'Salary',
  3: 'Investments',
  4: 'Part Time',
  5: 'Awards',
  6: 'Other Income'
};


// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // Function to fetch categories from backend
// Future<Map<int, String>> fetchCategories(String endpoint) async {
//   final response = await http.get(Uri.parse(endpoint));

//   if (response.statusCode == 200) {
//     // If the server returns a 200 OK response, parse the JSON
//     Map<String, dynamic> data = json.decode(response.body);

//     // Extract incomeCategories and expenseCategories
//     Map<int, String> incomeCategories =
//         Map<int, String>.from(data['incomeCategories']);
//     Map<int, String> expenseCategories =
//         Map<int, String>.from(data['expenseCategories']);

//     return {'income': incomeCategories, 'expense': expenseCategories};
//   } else {
//     // If the server returns an error response, throw an exception
//     throw Exception('Failed to load categories');
//   }
// }
