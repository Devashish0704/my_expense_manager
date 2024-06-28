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

class AddExpenseEvent extends BottomSheetEvent{}
class AddIncomeEvent extends BottomSheetEvent{}