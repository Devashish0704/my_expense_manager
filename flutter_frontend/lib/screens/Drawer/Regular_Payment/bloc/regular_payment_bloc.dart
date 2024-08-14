import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/drawer_service/regular_tranx_service.dart';
import 'package:meta/meta.dart';

part 'regular_payment_event.dart';
part 'regular_payment_state.dart';

class RegularPaymentBloc
    extends Bloc<RegularPaymentEvent, RegularPaymentState> {
  final RegularPaymentService regularPaymentService;
  final AuthService authService;

  RegularPaymentBloc(this.regularPaymentService, this.authService)
      : super(RegularPaymentInitial()) {
    on<FetchRegularPaymentsEvent>((event, emit) async {
      emit(RegularPaymentLoadingState());
      try {
        final regularPaymentsOfUser =
            await regularPaymentService.getRegularPayments(authService.userID);
        await Future.delayed(const Duration(seconds: 1));

        emit(RegularPaymentLoadedState(
            regularPaymentsOfUser: regularPaymentsOfUser));
      } catch (e) {
        emit(RegularPaymentErrorState(errorMessage: e.toString()));
      }
    });

    on<AddRegularPaymentEvent>((event, emit) async {
      emit(RegularPaymentLoadingState());
      try {
        final response = await regularPaymentService
            .addRegularPayments(event.regularPaymentData);
        if (response != null) {
          await Future.delayed(const Duration(seconds: 1));

          emit(RegularPaymentAddedState(
              isSuccess: true, message: 'Regular Payent Added'));
        } else {
          await Future.delayed(const Duration(seconds: 2));

          emit(RegularPaymentAddedState(
              isSuccess: false, message: 'Adding Regular Payment Failed'));
        }
      } catch (e) {
        emit(RegularPaymentAddedState(
            isSuccess: false, message: 'Failed to add Regular Payment'));
      }
    });

    on<SlideDeleteEvent>((event, emit) async {
      try {
        await regularPaymentService.deleteRegularPayments(event.dataId);
      } catch (e) {
        emit(RegularPaymentErrorState(errorMessage: 'Failed to delete expenses $e'));
      }
    });
  }
}

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadExpenseCategoriesEvent>(_onLoadExpenseCategories);
    on<LoadIncomeCategoriesEvent>(_onLoadIncomeCategories);
  }

  Future<void> _onLoadExpenseCategories(
      LoadExpenseCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadedState(true));
  }

  Future<void> _onLoadIncomeCategories(
      LoadIncomeCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadedState(false));
  }
}

class PaymentsBloc extends Bloc<CategoryEvent, PaymentsState> {
  PaymentsBloc() : super(PaymentsInitial()) {
    on<SelectUnlimitedEvent>(_onSelectUnlimited);
    on<SelectCustomizeEvent>(_onSelectCustomize);
  }

  void _onSelectUnlimited(
      SelectUnlimitedEvent event, Emitter<PaymentsState> emit) {
    emit(PaymentsLoadedState(isUnlimited: true, isCustomize: false));
  }

  void _onSelectCustomize(
      SelectCustomizeEvent event, Emitter<PaymentsState> emit) {
    emit(PaymentsLoadedState(isUnlimited: false, isCustomize: true));
  }
}
