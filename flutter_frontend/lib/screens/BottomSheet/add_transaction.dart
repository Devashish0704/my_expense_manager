import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/service/home_service/cat_service.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/add_expense_input.dart';
import 'package:flutter_frontend/widgets/Bottom_Sheet/add_income_input.dart';

class AddTransactionSheet extends StatelessWidget {
  const AddTransactionSheet({super.key});

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
                  Center(
                    child: BlocBuilder<FontSizeBloc, FontSizeState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<FontSizeBloc>()
                                    .add(SelectExpense());
                              },
                              child: Text(
                                'Add Expense',
                                style: TextStyle(
                                  fontSize: state.isExpenseSelected ? 24 : 12,
                                  fontWeight: state.isExpenseSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
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
                                context
                                    .read<FontSizeBloc>()
                                    .add(SelectIncome());
                              },
                              child: Text(
                                'Add Income',
                                style: TextStyle(
                                  fontSize: state.isIncomeSelected ? 24 : 12,
                                  fontWeight: state.isIncomeSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  BlocBuilder<FontSizeBloc, FontSizeState>(
              builder: (context, state) {
                if (state.isExpenseSelected) {
                  return CategoryService.expenseCategories.isNotEmpty
                      ? AddExpenseInput(
                          expenseCategories: CategoryService.expenseCategories,
                          expenseCategoriesCanBeDeleted: CategoryService.expenseCategoriesCanBeDeleted,
                        )
                      : const Center(child: CircularProgressIndicator());
                } else if (state.isIncomeSelected) {
                  return CategoryService.incomeCategories.isNotEmpty
                      ? AddIncomeInput(
                          incomeCategories: CategoryService.incomeCategories,
                          incomeCategoriesCanBeDeleted: CategoryService.incomeCategoriesCanBeDeleted,
                        )
                      : const Center(child: CircularProgressIndicator());
                } else {
                  return AddExpenseInput(
                    expenseCategories: CategoryService.expenseCategories,
                    expenseCategoriesCanBeDeleted: CategoryService.expenseCategoriesCanBeDeleted,
                  );
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
