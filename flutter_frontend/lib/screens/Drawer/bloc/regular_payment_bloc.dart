import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/regular_tranx_service.dart';
import 'package:meta/meta.dart';

part 'regular_payment_event.dart';
part 'regular_payment_state.dart';

class RegularPaymentBloc extends Bloc<RegularPaymentEvent, RegularPaymentState> {
  final RegularPaymentService regularPaymentService;
  final AuthService authService;

  RegularPaymentBloc(this.regularPaymentService, this.authService)
      : super(RegularPaymentInitial()) {
    on<FetchRegularPaymentsEvent>((event, emit) async {
      emit(RegularPaymentLoadingState());
      try {
        final regularPaymentsOfUser = await regularPaymentService.getRegularPayments(authService.userID);
        emit(RegularPaymentLoadedState(regularPaymentsOfUser: regularPaymentsOfUser));
      } catch (e) {
        emit(RegularPaymentErrorState(errorMessage: e.toString()));
      }
    });

     on<AddRegularPaymentEvent>((event, emit) async {
      emit(RegularPaymentLoadingState());
      try {
        final response = await regularPaymentService.addRegularPayments(event.regularPaymentData);
        if (response != null) {
          emit(RegularPaymentAddedState(isSuccess: true, message: 'Regular Payent Added'));
        } else {
          emit(RegularPaymentAddedState(
              isSuccess: false, message: 'Adding Regular Payment Failed'));
        }
      } catch (e) {
        emit(RegularPaymentAddedState(
            isSuccess: false, message: 'Failed to add Regular Payment'));
      }
    });
     on<LongPressEvent>((event, emit) async {
      try {
        (authService.userID, event.RPId);
        await regularPaymentService.deleteRegularPayments(event.RPId);
        emit(RegularPaymentDeletedState());
        add(FetchRegularPaymentsEvent());
      } catch (e) {
        emit(RegularPaymentErrorState(errorMessage: 'Failed to delete expenses $e'));
      }
    });
  }
}






