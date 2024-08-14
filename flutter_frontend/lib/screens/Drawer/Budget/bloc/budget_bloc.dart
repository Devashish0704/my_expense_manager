import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/drawer_service/budget_service.dart';
import 'package:meta/meta.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetService budgetService;
  final AuthService authService;
  BudgetBloc(this.budgetService, this.authService) : super(BudgetInitial()) {
    on<FetchBudgetEvent>((event, emit) async {
      emit(BudgetLoadingState());
      try {
        final budgetOfUser =
            await budgetService.checkBudgets(authService.userID);
        await Future.delayed(const Duration(seconds: 2));
        emit(BudgetLoadedState(BudgetsOfUser: budgetOfUser));
      } catch (e) {
        emit(BudgetErrorState(errorMessage: e.toString()));
      }
    });

    on<AddBudgetEvent>((event, emit) async {
      emit(BudgetLoadingState());
      try {
        final response = await budgetService.addBudget(event.addBudgetData);
        if (response != null) {
          emit(BudgetAddedState(isSuccess: true, message: 'Budget Added'));
        } else {
          emit(BudgetAddedState(
              isSuccess: false, message: 'Adding Budget Failed'));
        }
      } catch (e) {
        emit(BudgetAddedState(
            isSuccess: false, message: 'Failed to add Budget'));
      }
    });
    on<LongPressEvent>((event, emit) async {
      try {
        (authService.userID, event.budgetId);
        await budgetService.deleteBudget(event.budgetId);
        emit(BudgetDeletedState());
        add(FetchBudgetEvent());
      } catch (e) {
        emit(BudgetErrorState(errorMessage: 'Failed to delete expenses $e'));
      }
    });
  }
}
