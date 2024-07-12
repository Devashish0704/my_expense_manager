part of 'phone_verification_bloc.dart';

@immutable
sealed class PhoneVerificationEvent {}


class SendOtpEvent extends PhoneVerificationEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends PhoneVerificationEvent {
  final String phoneNumber;
  final String otp;

  VerifyOtpEvent({required this.phoneNumber, required this.otp});
}