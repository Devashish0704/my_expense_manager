import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';
import 'package:flutter_frontend/widgets/Home_Screen/bottom_navigation.dart';
import 'package:flutter_frontend/widgets/Home_Screen/fab.dart';
import 'package:flutter_frontend/widgets/balance_row.dart';
import 'package:flutter_frontend/widgets/calender.dart';
import 'package:flutter_frontend/widgets/user_data_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Calendar Widget
            Calendar(
              onDateSelected: (selectedDate) {
                // Handle the selected date
                print("Selected date: $selectedDate");
              },
              initialDate: DateTime.now(),
            ),
            const SizedBox(height: 10),
            const BalanceRow(),
            const SizedBox(height: 10),
            // Today's Expenses List
            Expanded(
              child: BlocListener<BottomSheetBloc, BottomSheetState>(
                listener: (context, state) {
                  if (state is ExpenseAddedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        key: UniqueKey(), // Ensures the SnackBar is shown only once
                        content: Text(state.message),
                        backgroundColor: state.isSuccess ? Colors.green : Colors.red,
                      ),
                    );
                  } else if (state is IncomeAddedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        key: UniqueKey(), // Ensures the SnackBar is shown only once
                        content: Text(state.message),
                        backgroundColor: state.isSuccess ? Colors.green : Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeLoadedState) {
                      return HomeDataCards(combinedList: state.combinedList);
                    } else if (state is HomeErrorState) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FabAdd(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigationFab(),
    );
  }
}
