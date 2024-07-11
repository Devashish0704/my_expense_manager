part of 'regular_payment_bloc.dart';

@immutable
sealed class RegularPaymentEvent {}

class FetchRegularPaymentsEvent extends RegularPaymentEvent {}

class AddRegularPaymentEvent extends RegularPaymentEvent {
  final Map<String, String> regularPaymentData;

  AddRegularPaymentEvent({required this.regularPaymentData});
}

class LongPressEvent extends RegularPaymentEvent {
  final int RPId;

  LongPressEvent({required this.RPId});


}