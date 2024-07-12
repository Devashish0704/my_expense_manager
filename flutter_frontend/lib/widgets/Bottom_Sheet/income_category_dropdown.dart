import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';

class IncomeCategoryDropdown extends StatefulWidget {
  final Map<int, String> incomeCategories; // Receive categories from parent
  final Map<int, String>
      incomeCategoriesCanBeDeleted; // Receive categories from parent
  final int? selectedCategory;
  final ValueChanged<int?> onCategoryChanged;

  const IncomeCategoryDropdown(
      {super.key,
      required this.incomeCategories,
      required this.incomeCategoriesCanBeDeleted,
      this.selectedCategory,
      required this.onCategoryChanged});

  @override
  State<IncomeCategoryDropdown> createState() => _IncomeCategoryDropdownState();
}

final _addCategoryKey = GlobalKey<FormState>();
int? selectedCategory;

class _IncomeCategoryDropdownState extends State<IncomeCategoryDropdown> {
  void _onAddCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController categoryController =
            TextEditingController();
        final TextEditingController descriptionController =
            TextEditingController();
        return AlertDialog(
          title: const Text('Add Income Category'),
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
                    'type': 'income',
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
          title: const Text('Remove Income Category'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children:
                  widget.incomeCategoriesCanBeDeleted.entries.map((entry) {
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
              labelText: 'Income Category',
              border: OutlineInputBorder(),
            ),
            value: selectedCategory,
            items: widget.incomeCategories.entries.map((entry) {
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
            validator: (value) {
              if (value == null) {
                return 'Please select a category';
              }
              return null;
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
