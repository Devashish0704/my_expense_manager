import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/data/expense_category_data.dart';
import 'package:flutter_frontend/service/cat_service.dart';
import 'package:flutter_frontend/service/expense_service.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseService expenseService = ExpenseService();
    List<Map<String, dynamic>>? expenses = expenseService.expenses;
    List<String> categoryIds = [];
    if (expenses != null) {
      for (var expense in expenses) {
        if (expense.containsKey('category_id')) {
          categoryIds.add(expense['category_id'].toString());
        }
      }
    }

    List<String> categoryNamesList = [];
    for (var categoryId in categoryIds) {
      int id = int.parse(categoryId);
      if (CategoryService.expenseCategories.containsKey(id)) {
        categoryNamesList.add(CategoryService.expenseCategories[id]!);
      }
    }

    Map<String, int> categoryCounts = {};
    for (var categoryName in categoryNamesList) {
      if (categoryCounts.containsKey(categoryName)) {
        categoryCounts[categoryName] = categoryCounts[categoryName]! + 1;
      } else {
        categoryCounts[categoryName] = 1;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
      ),
      body: Column(
        children: [
          Center(
            child: PieChartW(
              data: categoryCounts,
              colors: const [],
            ),
          ),
          Expanded(
            child: Center(
              child: ListView.builder(
                  itemCount: categoryCounts.length,
                  itemBuilder: (context, index) {
                    String ctaegoryName = categoryCounts.keys.elementAt(index);
                    Color categoryColor =
                        categoryColors[ctaegoryName] ?? Colors.grey;
                    return colourCard(ctaegoryName, categoryColor);
                  }),
            ),
          ),
          SizedBox(
            height: 300, // Adjust the height as needed
            child: PieChart(
              PieChartData(
                sections: getSections(categoryCounts, categoryColors),
                centerSpaceRadius: 50,
                sectionsSpace: 4,
              ),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.bounceIn, // Optional
            ),
          ),
        ],
      ),
    );
  }

  Widget colourCard(String category, Color color) {
    return Column(
      children: [
        const SizedBox(width: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              color: color,
            ),
            const SizedBox(width: 8),
            Text(category),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class PieChartW extends StatelessWidget {
  final Map<String, int> data;
  final List<Color> colors;

  const PieChartW({super.key, required this.data, required this.colors});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(150, 150),
      painter: PieChartPainter(data, categoryColors),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final Map<String, int> data;
  final Map<String, Color> colors;

  PieChartPainter(this.data, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    int total = data.values.reduce((a, b) => a + b);
    double startAngle = -pi / 2;

    data.forEach((category, count) {
      final sweepAngle = (count / total) * 2 * pi;
      const spaceAngle = 0.05;
      final paint = Paint()
        ..color = colors[category] ?? Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = (size.width - 60) / 2;

      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        startAngle,
        sweepAngle - spaceAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

List<PieChartSectionData> getSections(
    Map<String, int> categoryCounts, Map<String, Color> categoryColors) {
  return categoryCounts.entries.map((entry) {
    final category = entry.key;
    final count = entry.value;
    final color = categoryColors[category] ?? Colors.grey;
    return PieChartSectionData(
      color: color,
      value: count.toDouble(),
      title: category,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: kSecondaryTextColor,
      ),
    );
  }).toList();
}
