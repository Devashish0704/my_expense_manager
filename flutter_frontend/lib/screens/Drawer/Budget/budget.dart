import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/screens/Drawer/Budget/bloc/budget_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/Budget/budget_input.dart';
import 'package:flutter_frontend/service/home_service/cat_service.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BudgetBloc>(context).add(FetchBudgetEvent());
  }

  void showAddBudgetBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const BudgetInput()).whenComplete(() {
      context.read<BudgetBloc>().add(FetchBudgetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double addRegularButtonWidth = screenWidth * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
      ),
      body: BlocConsumer<BudgetBloc, BudgetState>(
        listener: (context, state) {
          if (state is BudgetAddedState) {
            final snackBar = SnackBar(
              content: Text(state.isSuccess
                  ? 'Budget Added Successfully'
                  : 'Failed to Add Budget: ${state.message}'),
              backgroundColor: state.isSuccess ? Colors.green : Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is BudgetLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BudgetLoadedState) {
            return ListView.builder(
              itemCount: state.BudgetsOfUser?.length,
              itemBuilder: (context, index) {
                final budget = state.BudgetsOfUser![index];
                return BudgetItem(
                  allocatedBudget: double.parse(budget['budget']['allocated_budget']),
                  currentAmountSpent: double.parse(budget['totalExpenses'].toString()),
                  category: budget['budget']['category_id'],
                  status: budget['status'],
                  budgetId: budget['budget']['id'],
                );
              },
            );
          } else if (state is BudgetErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(45, 71, 96, 137),
        child: Container(
          height: 60.0,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: showAddBudgetBottomSheet,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(addRegularButtonWidth,
                      50), // width: 80% of the screen width, height: 50
                  backgroundColor:
                      kPrimaryAccentColor, // Button background color
                  foregroundColor: kPrimaryTextColor, // Text color
                ),
                child: const Text('Add Budget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BudgetItem extends StatelessWidget {
  final double allocatedBudget;
  final double currentAmountSpent;
  final int category;
  final String status;
  final int budgetId;

  const BudgetItem({
    super.key,
    required this.allocatedBudget,
    required this.currentAmountSpent,
    required this.category,
    required this.status, required this.budgetId,
  });

  @override
  Widget build(BuildContext context) {
    double percentageUsed = currentAmountSpent / allocatedBudget;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onLongPress: () {
          BlocProvider.of<BudgetBloc>(context)
              .add(LongPressEvent(budgetId: budgetId));
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${CategoryService.expenseCategories[category]}',
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(
                    status,
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text('${(percentageUsed * 100).toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 10),
              Text('Allocated Budget: ${allocatedBudget.toStringAsFixed(2)}'),
              Text(
                  'Current Amount Spent: ${currentAmountSpent.toStringAsFixed(2)}'),
              const SizedBox(height: 10),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: percentageUsed),
                duration: const Duration(seconds: 1),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(kPrimaryAccentColor),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
