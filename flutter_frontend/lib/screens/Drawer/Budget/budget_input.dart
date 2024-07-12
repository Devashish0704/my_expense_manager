import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/Budget/bloc/budget_bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/cat_service.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/expense_category_dropdown.dart';
import 'package:intl/intl.dart';

class BudgetInput extends StatefulWidget {
  const BudgetInput({super.key});

  @override
  State<BudgetInput> createState() => _BudgetInputState();
}

class _BudgetInputState extends State<BudgetInput> {
  int? selectedCategory = 1;

  void _handleCategoryChanged(int? newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _allocatedBudgetController =
      TextEditingController();

  TextEditingController budgetStartDateController = TextEditingController();
  TextEditingController budgetEndDateController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final String allocatedBudget = _allocatedBudgetController.text;
      final String startDate = budgetStartDateController.text;
      final String endDate = budgetEndDateController.text;
      final String category_id = selectedCategory.toString();

      Map<String, String> addBudgetData = {
        'user_id': AuthService().userID.toString(),
        'allocated_budget': allocatedBudget,
        'start_date': startDate,
        'end_date': endDate,
        'category_id': category_id,
      };

      BlocProvider.of<BudgetBloc>(context)
          .add(AddBudgetEvent(addBudgetData: addBudgetData));

      _formKey.currentState!.reset();

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _allocatedBudgetController,
                decoration: InputDecoration(
                  labelText: 'Allocate Budget',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Budget';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid Budget';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ExpenseCategoryDropDown(
                expenseCategories: CategoryService.expenseCategories,
                expenseCategoriesCanBeDeleted:
                    CategoryService.expenseCategoriesCanBeDeleted,
                selectedCategory: selectedCategory,
                onCategoryChanged: _handleCategoryChanged,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: budgetStartDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
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
                      budgetStartDateController.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Start Date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SizedBox(height: 8),
              TextFormField(
                controller: budgetEndDateController,
                decoration: InputDecoration(
                  labelText: 'End Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 30)),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      budgetEndDateController.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter End Date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
