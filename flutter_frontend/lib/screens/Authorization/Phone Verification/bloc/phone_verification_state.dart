part of 'phone_verification_bloc.dart';

@immutable
sealed class PhoneVerificationState {}

final class PhoneVerificationInitial extends PhoneVerificationState {}


class OtpSentState extends PhoneVerificationState {
  final String message;

  OtpSentState({required this.message});
}

class OtpVerificationSuccessState extends PhoneVerificationState {
  final String message;

  OtpVerificationSuccessState({required this.message});
}

class PhoneVerificationLoadingState extends PhoneVerificationState {}

class PhoneVerificationErrorState extends PhoneVerificationState {
  final String error;

  PhoneVerificationErrorState({required this.error});
}