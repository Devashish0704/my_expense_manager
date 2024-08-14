import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/income_category_dropdown.dart';
import 'package:flutter_frontend/widgets/calender.dart';

class AddIncomeInput extends StatefulWidget {
  final Map<int, String> incomeCategories; // Receive categories from parent
  final Map<int, String>
      incomeCategoriesCanBeDeleted; // Receive categories from parent

  const AddIncomeInput(
      {super.key,
      required this.incomeCategories,
      required this.incomeCategoriesCanBeDeleted});

  @override
  State<AddIncomeInput> createState() => _AddIncomeInputState();
}

class _AddIncomeInputState extends State<AddIncomeInput> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  void _handleCategoryChanged(int? newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set a valid initial category from incomeCategories
    if (widget.incomeCategories.isNotEmpty) {
      selectedCategory = widget.incomeCategories.keys.first;
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                return 'Please enter an amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          IncomeCategoryDropdown(
              incomeCategories: widget.incomeCategories,
              incomeCategoriesCanBeDeleted: widget.incomeCategoriesCanBeDeleted,
              selectedCategory: selectedCategory,
              onCategoryChanged: _handleCategoryChanged),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            controller: descriptionController,
            
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
