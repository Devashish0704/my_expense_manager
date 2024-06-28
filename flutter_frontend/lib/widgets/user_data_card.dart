import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/expense_category_data.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';
import 'package:intl/intl.dart';

class HomeDataCards extends StatelessWidget {
  final List<Map<String, dynamic>> combinedList;

  const HomeDataCards({super.key, required this.combinedList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: combinedList.length,
      itemBuilder: (context, index) {
        final item = combinedList[index];
        if(item['type'] == 'expense'){
        return expenseCard(
          context,
          item["category_id"],
          item["date"],
          item["description"],
          item["amount"],
          item["id"],
        );
        }
        else if(item['type'] == 'income'){
          return incomeCard(
          context,
          item["category_id"],
          item["date"],
          item["description"],
          item["amount"],
          item["id"],
        );    
        }else {
          return Container(); 
        }
      },
    );
  }
}

Widget expenseCard(
    BuildContext context, categoryText, date, description, amount, id) {
  return GestureDetector(
    onTap: () {
      print('$id');
    },
    onLongPress: () {
      BlocProvider.of<HomeBloc>(context).add(LongPressEvent(dataId: id));
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${expenseCategories[categoryText]}'),
              Text(formatDate(date, 'EEE, MMM d, y')),
              Text('$description'),
            ],
          ),
          const Spacer(),
          Text('-$amount Rs'),
        ],
      ),
    ),
  );
}

 Widget incomeCard(
      BuildContext context, categoryText, date, description, amount, id) {
    return GestureDetector(
      onTap: () {
        print('$id');
      },
      onLongPress: () {
      BlocProvider.of<HomeBloc>(context).add(LongPressEvent(dataId: id));
    },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${incomeCategories[categoryText]}'),
                Text(formatDate(date, 'EEE, MMM d, y')),
                Text('$description'),
              ],
            ),
            const Spacer(),
            Text('+$amount Rs'),
          ],
        ),
      ),
    );
  }

String formatDate(String dateStr, String formatPattern) {
  DateTime dateTime = DateTime.parse(dateStr);
  return DateFormat(formatPattern).format(dateTime);
}



 

