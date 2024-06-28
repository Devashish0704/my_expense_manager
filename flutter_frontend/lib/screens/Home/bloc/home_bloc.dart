import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthService authService;

  HomeBloc(
    this.authService,
  ) : super(HomeInitialState()) {
    on<ShowAllEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final expenses =
            await authService.getExpensesOfUser(authService.userID);
        final income = await authService.getIncomeOfUser(authService.userID);

        // double totalExpense = 0.0;
        // for (var expense in expenses!) {
        //   totalExpense += expense['amount'];
        // }

        // Add type field to each item
        final expensesWithType = expenses!.map((expense) {
          expense['type'] = 'expense';
          return expense;
        }).toList();

        final incomeWithType = income!.map((incomeItem) {
          incomeItem['type'] = 'income';
          return incomeItem;
        }).toList();

        // Merge lists
        final combinedList = [...expensesWithType, ...incomeWithType];

        // Sort combined list by date in descending order
        combinedList.sort((a, b) =>
            DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));

        // Emit state with combined list
        emit(HomeLoadedState(combinedList: combinedList));
        // emit(TotalExpenseCalculatedState(totalExpense: totalExpense));
      } catch (e) {
        emit(HomeErrorState(errorMessage: 'Failed to fetch data'));
      }
    });

    

    // on<AddExpensesEvent>((event, emit) async {
    //   try {
    //     final response = await authService.addExpenseOfUser(event.expenseData);
    //     if (response != null) {
    //       emit(ExpenseAddedState(isSuccess: true, message: 'Expense Added'));
    //       add(ShowAllEvent());
    //     } else {
    //       emit(ExpenseAddedState(
    //           isSuccess: false, message: 'Adding Expense Failed'));
    //     }
    //   } catch (e) {
    //     emit(ExpenseAddedState(
    //         isSuccess: false, message: 'Failed to add expense'));
    //   }
    // });

    on<LongPressEvent>((event, emit) async {
      try {
        await authService.deleteExpenseOfUser(authService.userID, event.dataId);
        await authService.deleteIncomeOfUser(authService.userID, event.dataId);
        emit(ExpenseDeletedState());
        add(ShowAllEvent());
      } catch (e) {
        emit(HomeErrorState(errorMessage: 'Failed to delete expenses $e'));
      }
    });
  }
}
