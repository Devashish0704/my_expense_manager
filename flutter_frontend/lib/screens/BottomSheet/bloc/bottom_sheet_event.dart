part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetEvent {}

class SaveExpenseDetailsEvent extends BottomSheetEvent {
  final Map<String, String> expenseData;

  SaveExpenseDetailsEvent({required this.expenseData});
}

class SaveIncomeDetailsEvent extends BottomSheetEvent {
  final Map<String, String> incomeData;

  SaveIncomeDetailsEvent({required this.incomeData});
}

class AddExpenseEvent extends BottomSheetEvent {}

class AddIncomeEvent extends BottomSheetEvent {}

class FetchCategoriesEvent extends BottomSheetEvent {}

class AddCategoryEvent extends BottomSheetEvent {
  final Map<String, String> expeseCategoryData;

  AddCategoryEvent({required this.expeseCategoryData});
}

class DeleteCategoryEvent extends BottomSheetEvent {
  final int categoryId;

  DeleteCategoryEvent({required this.categoryId});
}
