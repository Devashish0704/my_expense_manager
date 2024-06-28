import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/expense_category_data.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/widgets/calender.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  _AddTransactionSheetState createState() => _AddTransactionSheetState();
}

@override
void initState() { 
  super.initState();
  context.read().add(any)
  
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom), // For handling keyboard overflow
      child: DraggableScrollableSheet(
        initialChildSize: 0.50,
        minChildSize: 0.25,
        maxChildSize: 0.75,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<BottomSheetBloc>()
                              .add(AddExpenseEvent());
                        },
                        child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
                          builder: (context, state) {
                            final isExpenseSelected = state is AddExpenseState;
                            return Text(
                              'Add Expense ',
                              style: TextStyle(
                                fontSize: isExpenseSelected ? 24 : 12,
                                fontWeight: isExpenseSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      const Text(
                        '/ ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<BottomSheetBloc>().add(AddIncomeEvent());
                        },
                        child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
                          builder: (context, state) {
                            final isIncomeSelected = state is AddIncomeState;
                            return Text(
                              'Add Income',
                              style: TextStyle(
                                fontSize: isIncomeSelected ? 24 : 12,
                                fontWeight: isIncomeSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<BottomSheetBloc, BottomSheetState>(
                    builder: (context, state) {
                      if (state is AddExpenseState) {
                        return AddExpenseInput();
                      } else if (state is AddIncomeState) {
                        return AddIncomeInput();
                      } else {
                        return AddExpenseInput();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddExpenseInput extends StatefulWidget {
  const AddExpenseInput({super.key});

  @override
  State<AddExpenseInput> createState() => _AddExpenseInputState();
}

class _AddExpenseInputState extends State<AddExpenseInput> {
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  int? selectedCategory = 1;
  DateTime _selectedDate = DateTime.now();

  void _onSaveExpense() async {
    if (_formKey.currentState!.validate()) {
      String amount = amountController.text;
      String? category = selectedCategory.toString();
      String description = descriptionController.text;
      String date = _selectedDate.toString();

      Map<String, String> addExpenseData = {
        'amount': amount,
        'category_id': category,
        'description': description,
        'date': date
      };
      print(addExpenseData);

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
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            value: selectedCategory,
            items: expenseCategories.entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedCategory = newValue;
              });
            },
          ),
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

class AddIncomeInput extends StatefulWidget {
  const AddIncomeInput({super.key});

  @override
  State<AddIncomeInput> createState() => _AddIncomeInputState();
}

class _AddIncomeInputState extends State<AddIncomeInput> {
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  int? selectedCategory = 1;
  DateTime _selectedDate = DateTime.now();

  void _onSaveIncome() async {
    if (_formKey.currentState!.validate()) {
      String amount = amountController.text;
      String? category = selectedCategory.toString();
      String description = descriptionController.text;
      String date = _selectedDate.toString();

      Map<String, String> addIncomeData = {
        'categoryid': category,
        'amount': amount,
        'description': description,
        'date': date
      };
      print(addIncomeData);

      BlocProvider.of<BottomSheetBloc>(context)
          .add(SaveIncomeDetailsEvent(incomeData: addIncomeData));

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
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            value: selectedCategory,
            items: incomeCategories.entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedCategory = newValue;
              });
            },
          ),
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
            onPressed: _onSaveIncome,
            child: const Text('Save'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
