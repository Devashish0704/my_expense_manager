import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';
import 'package:flutter_frontend/service/home_service/cat_service.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/expense_category_dropdown.dart';
import 'package:intl/intl.dart';

class HomeDataCards extends StatefulWidget {
  final List<Map<String, dynamic>> combinedList;
  final ScrollController scrollController;

  const HomeDataCards({super.key, required this.combinedList, required this.scrollController});

  @override
  State<HomeDataCards> createState() => _HomeDataCardsState();
}

int? selectedCategory = 1;
final _formKey = GlobalKey<FormState>();

TextEditingController dateController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController amountController = TextEditingController();

class _HomeDataCardsState extends State<HomeDataCards> {
  void _handleCategoryChanged(int? newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  void _showUpdateDialog(BuildContext context, int dataId,
      Map<String, dynamic> existingData, String type) {
    selectedCategory = existingData['category_id'];
    dateController.text = formatDate(existingData['date'], 'EEE, MMM d, y');
    descriptionController.text = existingData['description'] ?? '';
    amountController.text = existingData['amount'] ?? '';

    // Determine category data based on type
    Map<int, String> categoryData;
    Map<int, String> deletableCategories;
    String title ;

    if (type == 'expense') {
      categoryData = CategoryService.expenseCategories;
      deletableCategories = CategoryService.expenseCategoriesCanBeDeleted;
      title = 'Edit Expense';
    } else if (type == 'income') {
      categoryData = CategoryService.incomeCategories; // Assuming you have this
      deletableCategories = CategoryService
          .incomeCategoriesCanBeDeleted; // Assuming you have this
      title = 'Edit Income';
    } else {
      throw ArgumentError('Unknown type: $type');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(title),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ExpenseCategoryDropDown(
                    expenseCategories: categoryData,
                    expenseCategoriesCanBeDeleted: deletableCategories,
                    selectedCategory: selectedCategory,
                    onCategoryChanged: _handleCategoryChanged),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Expense Date',
                    hintText: 'Select Date',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateController.text = formattedDate;
                      });
                    }
                  },
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    // border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Update'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> updateData = {
                      'category_id': selectedCategory?.toString() ??
                          existingData['category_id'].toString(),
                      'date': dateController.text.isNotEmpty
                          ? dateController.text
                          : existingData['date'] ?? '',
                      'description': descriptionController.text.isNotEmpty
                          ? descriptionController.text
                          : existingData['description'] ?? '',
                      'amount': amountController.text.isNotEmpty
                          ? amountController.text
                          : existingData['amount'] ?? '',
                    };

                    // Remove any empty or unchanged fields
                    updateData.removeWhere((key, value) =>
                        value.isEmpty || value == existingData[key]);

                    if (type == 'expense') {
                      BlocProvider.of<HomeBloc>(context).add(UpdateExpenseEvent(
                        expenseId: dataId,
                        updateExpense: updateData,
                      ));
                    } else if (type == 'income') {
                      BlocProvider.of<HomeBloc>(context).add(UpdateIncomeEvent(
                        incomeId: dataId,
                        updateIncome: updateData,
                      ));
                    }

                    Navigator.pop(context);
                  }
                }),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget expenseCard(
      BuildContext context, categoryText, date, description, amount, id) {
    return GestureDetector(
      onLongPress: () {
        final existingExpense = {
          'category_id': categoryText,
          'date': date,
          'description': description,
          'amount': amount,
        };
        _showUpdateDialog(context, id, existingExpense, "expense");
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${CategoryService.expenseCategories[categoryText]}'),
                Text(formatDate(date, 'EEE, MMM d, y')),
                Text('$description'),
              ],
            ),
            const Spacer(),
            Text('-$amount Rs'),
          ],
        ),
      ),
    );
  }

  Widget incomeCard(
      BuildContext context, categoryText, date, description, amount, id) {
    return GestureDetector(
      onLongPress: () {
        final existingExpense = {
          'category_id': categoryText,
          'date': date,
          'description': description,
          'amount': amount,
        };
        _showUpdateDialog(context, id, existingExpense, "income");
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${CategoryService.incomeCategories[categoryText]}'),
                Text(formatDate(date, 'EEE, MMM d, y')),
                Text('$description'),
              ],
            ),
            const Spacer(),
            Text('+$amount Rs'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            controller: widget.scrollController,

      itemCount: widget.combinedList.length,
      itemBuilder: (context, index) {
        final item = widget.combinedList[index];
        if (item['type'] == 'expense') {
          return Dismissible(
            key: Key(item['id'].toString()), // Unique key for each item
            direction: DismissDirection.endToStart, // Swipe from right to left
            background: Container(
              alignment: Alignment.centerRight,
              color: kPrimaryBgColor,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 25,
              ),
            ),
            onDismissed: (direction) {
              BlocProvider.of<HomeBloc>(context)
                  .add(SlideDeleteEvent(dataId: item["id"]));
            },
            child: expenseCard(
              context,
              item["category_id"],
              item["date"],
              item["description"],
              item["amount"],
              item["id"],
            ),
          );
        } else if (item['type'] == 'income') {
          return Dismissible(
            key: Key(item['id'].toString()), // Unique key for each item
            direction: DismissDirection.endToStart, // Swipe from right to left
            background: Container(
              alignment: Alignment.centerRight,
              color: kPrimaryBgColor,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 25,
              ),
            ),
            onDismissed: (direction) {
              // Handle item removal here
              BlocProvider.of<HomeBloc>(context)
                  .add(SlideDeleteEvent(dataId: item["id"]));
            },
            child: incomeCard(
              context,
              item["category_id"],
              item["date"],
              item["description"],
              item["amount"],
              item["id"],
            ),
          );
        } else {
          return Container(); // Return an empty container if neither expense nor income
        }
      },
    );
  }
}

String formatDate(String dateStr, String formatPattern) {
  DateTime dateTime = DateTime.parse(dateStr);
  return DateFormat(formatPattern).format(dateTime);
}
