import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/home_service/cat_service.dart';
import 'package:flutter_frontend/service/home_service/expense_service.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  Map<String?, double> categoryExpenses = {};
  bool isLoading = true;
  bool isAnimating = true; // Track initial animation state
  final Duration animDuration =
      const Duration(milliseconds: 2000); // Animation duration

  final List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.pink,
    Colors.teal,
    Colors.lime,
    Colors.indigo,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    ExpenseService expenseService = ExpenseService();
    await expenseService
        .getExpensesOfUser(AuthService().userID); // Replace with actual user ID
    calculateCategoryExpenses(expenseService.expenses);
    setState(() {
      isLoading = false;
    });
    // Start animation for a short duration
    await Future.delayed(animDuration);
    setState(() {
      isAnimating = false; // Stop animation and show actual data
    });
  }

  void calculateCategoryExpenses(List<Map<String, dynamic>>? expenses) {
    Map<int, String> expenseCategories = CategoryService.expenseCategories;
    if (expenses != null) {
      for (var expense in expenses) {
        String? categoryName = expenseCategories[expense['category_id']];
        if (categoryName != null) {
          double amount = double.parse(expense['amount']);
          if (categoryExpenses.containsKey(categoryName)) {
            categoryExpenses[categoryName] =
                (categoryExpenses[categoryName] ?? 0) + amount;
          } else {
            categoryExpenses[categoryName] = amount;
          }
        }
      }
    }

    // Print calculated category expenses for debugging
    print("Calculated category expenses: $categoryExpenses");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (categoryExpenses.isNotEmpty) ...[
            const SizedBox(height: 20),
            SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: BarChart(
                  isAnimating ? randomData() : mainBarData(),
                  swapAnimationDuration: animDuration,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ] else ...[
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barGroups: categoryExpenses.entries.map((entry) {
        int index = categoryExpenses.keys.toList().indexOf(entry.key);
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: entry.value,
              color: getColor(index),
              width: 16,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        );
      }).toList(),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
           axisNameWidget: const Text("Categories",  style: TextStyle(color: kPrimaryTextColor)),
          axisNameSize: 30,
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final category = categoryExpenses.keys.elementAt(value.toInt());
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child:
                    Text(category ?? '', style: const TextStyle(fontSize: 10)),
              );
            },
          ),
        ),
        leftTitles: const AxisTitles(
          axisNameWidget: Text("Expenses",  style: TextStyle(color: kPrimaryTextColor)),
          axisNameSize: 30,
          sideTitles: SideTitles(
            reservedSize: 40,
            showTitles: true,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: const FlGridData(show: true),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barGroups: List.generate(categoryExpenses.length, (i) {
        return BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: Random().nextDouble() * 100,
              color: getColor(i),
              width: 16,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        );
      }),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          axisNameWidget: const Text("Categories",  style: TextStyle(color: kPrimaryTextColor)),
          axisNameSize: 30,
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final category = categoryExpenses.keys.elementAt(value.toInt());
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child:
                    Text(category ?? '', style: const TextStyle(fontSize: 10)),
              );
            },
          ),
        ),
        leftTitles: const AxisTitles(
          axisNameWidget: Text("Expenses", style: TextStyle(color: kPrimaryTextColor),),
          axisNameSize: 30,
          sideTitles: SideTitles(
            reservedSize: 40,
            showTitles: true,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: const FlGridData(show: true),
    );
  }

  Color getColor(int index) {
    return colorList[index % colorList.length];
  }
}
