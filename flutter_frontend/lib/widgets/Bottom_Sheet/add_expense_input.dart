import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/expense_category_dropdown.dart';
import 'package:flutter_frontend/widgets/calender.dart';

class AddExpenseInput extends StatefulWidget {
  final Map<int, String> expenseCategories; // Receive categories from parent
  final Map<int, String>
      expenseCategoriesCanBeDeleted; // Receive categories from parent

  const AddExpenseInput(
      {super.key,
      required this.expenseCategories,
      required this.expenseCategoriesCanBeDeleted});

  @override
  State<AddExpenseInput> createState() => _AddExpenseInputState();
}

class _AddExpenseInputState extends State<AddExpenseInput> {
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? selectedCategory = 1;
  final TextEditingController descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _handleCategoryChanged(int? newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  void _onSaveExpense() async {
    if (_formKey.currentState!.validate()) {
      String amount = amountController.text;
      String? category = selectedCategory.toString();
      String? description = descriptionController.text;
      String date = _selectedDate.toString();

      Map<String, String> addExpenseData = {
        'amount': amount,
        'category_id': category,
        'description': description,
        'date': date
      };

      BlocProvider.of<BottomSheetBloc>(context)
          .add(SaveExpenseDetailsEvent(expenseData: addExpenseData));

      Navigator.pop(context);
    }
  }

  void _onDateSelected(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 25),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            controller: amountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ExpenseCategoryDropDown(
              expenseCategories: widget.expenseCategories,
              expenseCategoriesCanBeDeleted:
                  widget.expenseCategoriesCanBeDeleted,
              selectedCategory: selectedCategory,
              onCategoryChanged: _handleCategoryChanged),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            controller: descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Calendar(
            onDateSelected: _onDateSelected,
            initialDate: DateTime.now(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _onSaveExpense,
            child: const Text('Save'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
