part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class ShowAllEvent extends HomeEvent {}

class ClearDataEvent extends HomeEvent {} // Add this event

class SlideDeleteEvent extends HomeEvent {
  final int dataId;

  SlideDeleteEvent({required this.dataId});
}

class UpdateExpenseEvent extends HomeEvent {
  final int expenseId;
  final Map<String, String> updateExpense;

  UpdateExpenseEvent({required this.expenseId, required this.updateExpense});
}
class UpdateIncomeEvent extends HomeEvent {
  final int incomeId;
  final Map<String, String> updateIncome;

  UpdateIncomeEvent({required this.incomeId, required this.updateIncome});

}
