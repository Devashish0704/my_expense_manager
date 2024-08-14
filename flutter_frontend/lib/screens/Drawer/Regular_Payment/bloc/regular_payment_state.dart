part of 'regular_payment_bloc.dart';

@immutable
sealed class RegularPaymentState {}

final class RegularPaymentInitial extends RegularPaymentState {}

final class RegularPaymentLoadingState extends RegularPaymentState {}

final class RegularPaymentLoadedState extends RegularPaymentState {
  final List<Map<String, dynamic>>? regularPaymentsOfUser;

  RegularPaymentLoadedState({required this.regularPaymentsOfUser});
}

class RegularPaymentAddedState extends RegularPaymentState {
  final bool isSuccess;
  final String message;

  RegularPaymentAddedState({required this.isSuccess, required this.message});

}

final class RegularPaymentErrorState extends RegularPaymentState {
  final String errorMessage;

  RegularPaymentErrorState({required this.errorMessage});

}

final class RegularPaymentDeletedState extends RegularPaymentState {}


@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  // final Map<int, String> categories;
  final bool isExpense;
  CategoryLoadedState(this.isExpense);
}


@immutable
sealed class PaymentsState {}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoadedState extends PaymentsState {
  final bool isUnlimited;
  final bool isCustomize;
  PaymentsLoadedState({required this.isUnlimited, required this.isCustomize});
}
