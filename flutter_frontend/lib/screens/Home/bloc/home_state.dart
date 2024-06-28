part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

// final class IncomeLoadingState extends HomeState {}



final class HomeLoadedState extends HomeState {
  final List<Map<String, dynamic>> combinedList;
  // final double totalExpenseAmount;

  HomeLoadedState({required this.combinedList});


}

final class IncomeLoadedState extends HomeState {
  final List<Map<String, dynamic>> income;

  IncomeLoadedState({required this.income});
}


final class TotalExpenseCalculatedState extends HomeState {
  final double totalExpense;

  TotalExpenseCalculatedState({required this.totalExpense});
}





final class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}

// final class IncomeErrorState extends HomeState {
//   final String errorMessage;

//   IncomeErrorState({required this.errorMessage});
// }

final class ExpenseDeletedState extends HomeState {}
