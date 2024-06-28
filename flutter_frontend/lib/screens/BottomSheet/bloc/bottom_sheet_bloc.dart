import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:meta/meta.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  final AuthService authService;

  BottomSheetBloc(this.authService) : super(AddExpenseState()) {
    on<SaveExpenseDetailsEvent>((event, emit) async {
      
      emit(BottomSheetLoadingState());
      try {
        final response = await authService.addExpenseOfUser(event.expenseData);
        if (response != null) {
          emit(ExpenseAddedState(isSuccess: true, message: 'Expense Added'));
        } else {
          emit(ExpenseAddedState(isSuccess: false, message: 'Adding Expense Failed'));
        }
      } catch (e) {
        emit(ExpenseAddedState(isSuccess: false, message: 'Failed to add expense'));
      }
    });

    on<SaveIncomeDetailsEvent>((event, emit) async {
      emit(BottomSheetLoadingState());
      try {
        final response = await authService.addIncomeOfUser(event.incomeData);
        if (response != null) {
          emit(IncomeAddedState(isSuccess: true, message: 'Income Added'));
        } else {
          emit(IncomeAddedState(isSuccess: false, message: 'Adding Income Failed'));
        }
      } catch (e) {
        emit(IncomeAddedState(isSuccess: false, message: 'Failed to add income'));
      }
    });

    on<AddExpenseEvent>((event, emit) {
      emit(AddExpenseState());
    });

    on<AddIncomeEvent>((event, emit) {
      emit(AddIncomeState());
    });
  }
}
