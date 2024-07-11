part of 'log_in_bloc.dart';

@immutable
sealed class LogInState {}

final class LogInInitialState extends LogInState {}
final class LogInValidState extends LogInState {}
final class LogInErrorState extends LogInState {
    final String errorMessage;

  LogInErrorState({required this.errorMessage});
}

final class LogInLoadingState extends LogInState {}

class LogInSuccessState extends LogInState {}

class LogInFailureState extends LogInState {
  final String errorMessage;

  LogInFailureState({required this.errorMessage});
}