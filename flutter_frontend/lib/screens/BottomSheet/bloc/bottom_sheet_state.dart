part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetState {}

final class BottomSheetInitial extends BottomSheetState {}

final class AddExpenseState extends BottomSheetState {}

final class AddIncomeState extends BottomSheetState {}

final class BottomSheetLoadingState extends BottomSheetState {}

class ExpenseAddedState extends BottomSheetState {
  final bool isSuccess;
  final String message;

  ExpenseAddedState({required this.isSuccess, required this.message});
}
class IncomeAddedState extends BottomSheetState {
  final bool isSuccess;
  final String message;

  IncomeAddedState({required this.isSuccess, required this.message});
}
