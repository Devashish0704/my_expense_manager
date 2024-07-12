import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/phone_verification_service.dart';
import 'package:meta/meta.dart';

part 'phone_verification_event.dart';
part 'phone_verification_state.dart';

class PhoneVerificationBloc extends Bloc<PhoneVerificationEvent, PhoneVerificationState> {
    final PhoneVerificationService phoneVerificationService;

  PhoneVerificationBloc(this.phoneVerificationService) : super(PhoneVerificationInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(PhoneVerificationLoadingState());
      try {
        final response = await phoneVerificationService.sendOtp({'phoneNumber': event.phoneNumber});
        if (response != null) {
          emit(OtpSentState(message: response));
        } else {
          emit(PhoneVerificationErrorState(error: 'Failed to send OTP.'));
        }
      } catch (e) {
        emit(PhoneVerificationErrorState(error: e.toString()));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(PhoneVerificationLoadingState());
      try {
        
        final response = await phoneVerificationService.verifyOtp({
          'phoneNumber': event.phoneNumber,
          'otp': event.otp
        });
        if (response != null) {
          emit(OtpVerificationSuccessState(message: response));
        } else {
          emit(PhoneVerificationErrorState(error: 'Failed to verify OTP.'));
        }
      } catch (e) {
        emit(PhoneVerificationErrorState(error: e.toString()));
      }
    });
  }
}
