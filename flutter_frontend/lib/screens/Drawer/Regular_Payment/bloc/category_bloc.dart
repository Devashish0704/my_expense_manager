import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/cat_service.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
      on<LoadExpenseCategoriesEvent>((event, emit) {
      emit(CategoryAndPaymentsState(
        categories: CategoryService.expenseCategories,
        isExpense: true,
        isUnlimited: true,
        isCustomize: false,
      ));
    });

    on<LoadIncomeCategoriesEvent>((event, emit) {
      emit(CategoryAndPaymentsState(
        categories: CategoryService.incomeCategories,
        isExpense: false,
        isUnlimited: true,
        isCustomize: false,
      ));
    });

    on<SelectUnlimitedEvent>((event, emit) {
      if (state is CategoryAndPaymentsState) {
        var currentState = state as CategoryAndPaymentsState;
        emit(CategoryAndPaymentsState(
          categories: currentState.categories,
          isExpense: currentState.isExpense,
          isUnlimited: true,
          isCustomize: false,
        ));
      }
    });

    on<SelectCustomizeEvent>((event, emit) {
      if (state is CategoryAndPaymentsState) {
        var currentState = state as CategoryAndPaymentsState;
        emit(CategoryAndPaymentsState(
          categories: currentState.categories,
          isExpense: currentState.isExpense,
          isUnlimited: false,
          isCustomize: true,
        ));
      }
    });
    
  }
}

