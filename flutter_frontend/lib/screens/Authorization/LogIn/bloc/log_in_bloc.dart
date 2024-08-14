import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:meta/meta.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final AuthService authService;

  LogInBloc(this.authService) : super(LogInInitialState()) {
    on<LogInTextChangeEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(LogInErrorState(errorMessage: "Enter a valid Email"));
      } else if (event.passwordValue.length < 6) {
        emit(LogInErrorState(errorMessage: "Enter a valid Password"));
      } else {
        emit(LogInValidState());
      }
    });

    on<LogInSubmittedEvent>((event, emit) async {
      emit(LogInLoadingState());
      try {
        String? loginResponse = await authService.login({
          'email': event.email,
          'password': event.password,
        });

        if (loginResponse != null) {
          await Future.delayed(const Duration(seconds: 1));
          emit(LogInSuccessState());
        } else {
          emit(LogInFailureState(errorMessage: "Login failed"));
        }
      } catch (e) {
        emit(LogInFailureState(errorMessage: "Login error: $e"));
      }
    });
  }
}
