part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpTextChangeEvent extends SignUpEvent {
  final String fullnameValue;
  final String emailValue;
  final String passwordValue;

  SignUpTextChangeEvent(
      {required this.fullnameValue,
      required this.emailValue,
      required this.passwordValue});
}

class SignUpSubmittedEvent extends SignUpEvent {
  final String fullname;
  final String email;
  final String password;

  SignUpSubmittedEvent(
      {required this.fullname, required this.email, required this.password});
}
