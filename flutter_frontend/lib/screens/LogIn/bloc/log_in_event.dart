part of 'log_in_bloc.dart';

@immutable
sealed class LogInEvent {}

class LogInTextChangeEvent extends LogInEvent {
   final String emailValue;
  final String passwordValue;

  LogInTextChangeEvent({required this.emailValue, required this.passwordValue});

}
class LogInSubmittedEvent extends LogInEvent {
   final String email;
  final String password;

  LogInSubmittedEvent({required this.email, required this.password});

}