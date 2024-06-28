import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/constants.dart';
import 'package:flutter_frontend/screens/BottomSheet/add_expense.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';

class FabAdd extends StatelessWidget {
  const FabAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return const AddTransactionSheet(); // This is the bottom sheet content
          },
        ).whenComplete(() {
          // Fetch expenses again after adding an expense
          context.read<HomeBloc>().add(ShowAllEvent());
        });
      },
      backgroundColor: kPrimaryAccentColor,
      elevation: 10.0, // Set the elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: const Icon(Icons.add),
    );
  }
}
