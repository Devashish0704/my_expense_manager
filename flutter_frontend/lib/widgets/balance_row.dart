import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';

class BalanceRow extends StatefulWidget {
  const BalanceRow({super.key});

  @override
  State<BalanceRow> createState() => _BalanceRowState();
}

class _BalanceRowState extends State<BalanceRow> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedState) {
          final combinedList = state.combinedList;
          double totalIncome = 0.0;
          double totalExpense = 0.0;
          for (var item in combinedList) {
            if (item['type'] == 'income') {
              double amount = double.parse(item['amount']);
              totalIncome += amount;
            } else if (item['type'] == 'expense') {
              double amount = double.parse(item['amount']);
              totalExpense += amount;
            }
          }
          double balance = totalIncome - totalExpense;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Expenses",
                      style: TextStyle(color: kSecondaryTextColor),
                    ),
                    Text(
                      "-$totalExpense",
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Income",
                      style: TextStyle(color: kSecondaryTextColor),
                    ),
                    Text(
                      "+$totalIncome",
                      style: const TextStyle(color: Colors.green),
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Balance",
                      style: TextStyle(color: kSecondaryTextColor),
                    ),
                    Text(
                      "$balance",
                      style: const TextStyle(color: kPrimaryTextColor),
                    )
                  ],
                ),
              ),
            ],
          );
        } else if (state is HomeErrorState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
