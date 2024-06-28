part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchExpensesEvent extends HomeEvent {}

class FetchIncomeEvent extends HomeEvent {}

// class ShowExpenseEvent extends HomeEvent {}
// class ShowIncomeEvent extends HomeEvent {}
class ShowAllEvent extends HomeEvent {}




class LongPressEvent extends HomeEvent {
  final int dataId;

  LongPressEvent({required this.dataId});

}
