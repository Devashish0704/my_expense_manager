import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/DraweHeader/bloc/profile_pic_bloc.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';
import 'package:flutter_frontend/widgets/Home_Screen/bottom_navigation.dart';
import 'package:flutter_frontend/screens/Drawer/drawer.dart';
import 'package:flutter_frontend/widgets/Home_Screen/fab.dart';
import 'package:flutter_frontend/widgets/balance_row.dart';
import 'package:flutter_frontend/widgets/calender.dart';
import 'package:flutter_frontend/widgets/user_data_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BottomSheetBloc>(context).add(FetchCategoriesEvent());
    BlocProvider.of<HomeBloc>(context).add(ShowAllEvent());
    BlocProvider.of<ProfilePicBloc>(context).add(GetImageEvent());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final ScrollController scrollController = ScrollController();

    void scrollToDate(
        DateTime selectedDate, List<Map<String, dynamic>> combinedList) {
      int index = combinedList.indexWhere((transaction) {
        DateTime transactionDate = DateTime.parse(transaction['date']);
        return transactionDate.year == selectedDate.year &&
            transactionDate.month == selectedDate.month &&
            transactionDate.day == selectedDate.day;
      });

      if (index != -1) {
        scrollController.animateTo(
          index *
              80.0, // Adjust the multiplier according to the height of your items
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        // Optionally show a message if no transactions found for the selected date
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No transactions found for the selected date')),
        );
      }
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.logout_outlined),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            Calendar(
              onDateSelected: (selectedDate) {
                final homeState = context.read<HomeBloc>().state;
                if (homeState is HomeLoadedState) {
                  scrollToDate(selectedDate, homeState.combinedList);
                }
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
                        key:
                            UniqueKey(), // Ensures the SnackBar is shown only once
                        content: Text(state.message),
                        backgroundColor:
                            state.isSuccess ? Colors.green : Colors.red,
                      ),
                    );
                  } else if (state is IncomeAddedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        key:
                            UniqueKey(), // Ensures the SnackBar is shown only once
                        content: Text(state.message),
                        backgroundColor:
                            state.isSuccess ? Colors.green : Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeLoadedState) {
                      return HomeDataCards(
                        combinedList: state.combinedList,
                        scrollController: scrollController,
                      );
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
      drawer: const HomeDrawer(),
      floatingActionButton: const FabAdd(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationFab(
        scaffoldKey: scaffoldKey,
      ),
    );
  }
}
