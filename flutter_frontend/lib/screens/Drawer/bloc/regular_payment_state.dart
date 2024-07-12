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
