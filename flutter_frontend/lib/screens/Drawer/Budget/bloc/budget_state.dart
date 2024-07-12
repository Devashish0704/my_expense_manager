part of 'budget_bloc.dart';

@immutable
sealed class BudgetState {}

final class BudgetInitial extends BudgetState {}


final class BudgetLoadingState extends BudgetState {}

final class BudgetLoadedState extends BudgetState {
  final List<Map<String, dynamic>>? BudgetsOfUser;

  BudgetLoadedState({required this.BudgetsOfUser});

}

class BudgetAddedState extends BudgetState {
  final bool isSuccess;
  final String message;

  BudgetAddedState({required this.isSuccess, required this.message});


}

final class BudgetErrorState extends BudgetState {
  final String errorMessage;

  BudgetErrorState({required this.errorMessage});


}

final class BudgetDeletedState extends BudgetState {}
