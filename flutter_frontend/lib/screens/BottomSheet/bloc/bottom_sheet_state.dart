part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetState {}

final class BottomSheetInitial extends BottomSheetState {}

final class AddExpenseState extends BottomSheetState {}

// final class AddIncomeState extends BottomSheetState {}

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

final class CategoryLoadingState extends BottomSheetState {}

final class CategoryLoadedState extends BottomSheetState {
    final Map<int, String> incomeCategories;
  final Map<int, String> expenseCategories;

  CategoryLoadedState({required this.incomeCategories, required this.expenseCategories});
}
final class CategoryForDeletionLoadedState extends BottomSheetState {
    final Map<int, String> incomeCategories;
    final Map<int, String> expenseCategories;

  CategoryForDeletionLoadedState({required this.incomeCategories, required this.expenseCategories});

}

final class CategoryErrorState extends BottomSheetState {
    final String error;

  CategoryErrorState({required this.error});

}

final class ExpenseCategoryAddedState extends BottomSheetState {}

final class CategoryDeletedState extends BottomSheetState {}

class FontSizeState {
  final bool isExpenseSelected;
  final bool isIncomeSelected;

  FontSizeState({required this.isExpenseSelected, required this.isIncomeSelected});

  factory FontSizeState.initial() {
    return FontSizeState(isExpenseSelected: true, isIncomeSelected: false);
  }
}

