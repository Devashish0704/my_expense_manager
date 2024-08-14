import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/home_service/expense_service.dart';
import 'package:flutter_frontend/service/home_service/income_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ExpenseService expenseService;
  final IncomeService incomeService;
  final AuthService authService;

  HomeBloc(this.expenseService, this.incomeService, this.authService)
      : super(HomeInitialState()) {
    on<ShowAllEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final expenses =
            await expenseService.getExpensesOfUser(authService.userID);
        final income = await incomeService.getIncomeOfUser(authService.userID);

        final expensesWithType = expenses!.map((expense) {
          expense['type'] = 'expense';
          return expense;
        }).toList();

        final incomeWithType = income!.map((incomeItem) {
          incomeItem['type'] = 'income';
          return incomeItem;
        }).toList();

        final combinedList = [...expensesWithType, ...incomeWithType];

        combinedList.sort((a, b) =>
            DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));

        emit(HomeLoadedState(combinedList: combinedList));
      } catch (e) {
        emit(HomeErrorState(errorMessage: 'Failed to fetch data $e'));
      }
    });

    on<ClearDataEvent>((event, emit) {
      emit(
          HomeInitialState()); // Reset to initial state or any other empty state
    });

    on<SlideDeleteEvent>((event, emit) async {
      try {
        await expenseService.deleteExpenseOfUser(
            authService.userID, event.dataId);
        await incomeService.deleteIncomeOfUser(
            authService.userID, event.dataId);
      } catch (e) {
        emit(HomeErrorState(errorMessage: 'Failed to delete expenses $e'));
      }
    });

    on<UpdateExpenseEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        String? message = await expenseService.updateExpenseOfUser(
            event.updateExpense, event.expenseId);
        if (message != null) {
          emit(ExpenseUpdatedState());
        } else {
          emit(HomeErrorState(errorMessage: 'Failed to update expense'));
        }
      } catch (e) {
        emit(HomeErrorState(errorMessage: e.toString()));
      }
      add(ShowAllEvent());
    });
    on<UpdateIncomeEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        String? message = await expenseService.updateIncomeOfUser(
            event.updateIncome, event.incomeId);
        if (message != null) {
          emit(ExpenseUpdatedState());
        } else {
          emit(HomeErrorState(errorMessage: 'Failed to update income'));
        }
      } catch (e) {
        emit(HomeErrorState(errorMessage: e.toString()));
      }
      add(ShowAllEvent());
    });
  }
}
