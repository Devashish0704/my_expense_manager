part of 'budget_bloc.dart';

@immutable
sealed class BudgetEvent {}


class FetchBudgetEvent extends BudgetEvent {}

class AddBudgetEvent extends BudgetEvent {
  final Map<String, String> addBudgetData;

  AddBudgetEvent({required this.addBudgetData});

}

class LongPressEvent extends BudgetEvent {
  final int budgetId;

  LongPressEvent({required this.budgetId});

}