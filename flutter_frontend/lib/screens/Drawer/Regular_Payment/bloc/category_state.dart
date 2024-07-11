part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}


class CategoryLoadedState extends CategoryState {
  final Map<int, String> categories;
  final bool isExpense;
  CategoryLoadedState(this.categories, this.isExpense);
}

class PaymentsState extends CategoryState {
  final bool isUnlimited;
  final bool isCustomize;
  PaymentsState({required this.isUnlimited, required this.isCustomize});
}

class CategoryAndPaymentsState extends CategoryState {
  final Map<int, String> categories;
  final bool isExpense;
  final bool isUnlimited;
  final bool isCustomize;

  CategoryAndPaymentsState({
    required this.categories,
    required this.isExpense,
    required this.isUnlimited,
    required this.isCustomize,
  });
}