import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';

class ExpenseCategoryDropDown extends StatefulWidget {
  final Map<int, String> expenseCategories; // Receive categories from parent
  final Map<int, String> expenseCategoriesCanBeDeleted;
  final int? selectedCategory;
  final ValueChanged<int?> onCategoryChanged;

  const ExpenseCategoryDropDown(
      {super.key,
      required this.expenseCategories,
      required this.expenseCategoriesCanBeDeleted,
      required this.selectedCategory,
      required this.onCategoryChanged});

  @override
  State<ExpenseCategoryDropDown> createState() =>
      _ExpenseCategoryDropDownState();
}

class _ExpenseCategoryDropDownState extends State<ExpenseCategoryDropDown> {
  final _addCategoryKey = GlobalKey<FormState>();
  int? selectedCategory;

  void _onAddCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController categoryController =
            TextEditingController();
        final TextEditingController descriptionController =
            TextEditingController();
        return AlertDialog(
          title: const Text('Add Expense Category'),
          content: SingleChildScrollView(
            child: Form(
              key: _addCategoryKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                      controller: categoryController,
                      decoration:
                          const InputDecoration(hintText: 'Category Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Category';
                        }
                        return null;
                      }),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Category Description if any'),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_addCategoryKey.currentState!.validate()) {
                  String newCategory = categoryController.text;
                  String? newCategoryDescription = descriptionController.text;

                  Map<String, String> addCategoryData = {
                    'name': newCategory,
                    'description': newCategoryDescription,
                    'type': 'expense',
                    'user_id': AuthService().userID.toString()
                  };
                  BlocProvider.of<BottomSheetBloc>(context).add(
                      AddCategoryEvent(expeseCategoryData: addCategoryData));
                }
                Navigator.of(context).pop();
                BlocProvider.of<BottomSheetBloc>(context)
                    .add(FetchCategoriesEvent());
              },
            ),
          ],
        );
      },
    );
  }

  void _onRemoveCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Expense Category'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children:
                  widget.expenseCategoriesCanBeDeleted.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: InputChip(
                    label: Text(entry.value),
                    onPressed: () {
                      BlocProvider.of<BottomSheetBloc>(context)
                          .add(DeleteCategoryEvent(categoryId: entry.key));
                      BlocProvider.of<BottomSheetBloc>(context)
                          .add(FetchCategoriesEvent());
                      // Implement delete category logic here
                      print('Selected Category ID: ${entry.key}');
                      // You can call a function to delete the category by its ID here
                      Navigator.pop(context); // Close dialog after action
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            const Text(
              "Tap on a Category to Reomove",
              style: TextStyle(fontSize: 12),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog without action
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Expense Category',
              border: OutlineInputBorder(),
            ),
            value: widget.selectedCategory,
            items: widget.expenseCategories.entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedCategory = newValue;
                widget.onCategoryChanged(newValue);
              });
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  color: kPrimaryAccentColor,
                  iconSize: 30,
                  onPressed: _onAddCategory,
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: kPrimaryAccentColor,
                  iconSize: 30,
                  onPressed: _onRemoveCategory,
                ),
              ],
            ),
            const Text("Coustomize")
          ],
        ),
      ],
    );
  }
}
