import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;

  SignUpBloc(this.authService) : super(SignUpInitialState()) {
    on<SignUpTextChangeEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignUpErrorState(errorMessage: "Enter a valid Email"));
      } else if (event.passwordValue.length < 6) {
        emit(SignUpErrorState(errorMessage: "Enter a valid Password"));
      } else {
        emit(SignUpValidState());
      }
    });

    on<SignUpSubmittedEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        String? status = await AuthService().signup({
          "name": event.fullname,
          'email': event.email,
          'password': event.password,
        });
        if (status != null) {
          emit(SignUpSuccessState());
        } else {
          emit(SignUpErrorState(errorMessage: "Sign Up failed"));
        }
      } catch (e) {
        emit(SignUpFailureState(errorMessage: "Sign up error: $e"));
      }
    });
  }
}
