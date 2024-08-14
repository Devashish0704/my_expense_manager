import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/home_service/cat_service.dart';
import 'package:flutter_frontend/service/home_service/expense_service.dart';
import 'package:flutter_frontend/service/home_service/income_service.dart';
import 'package:meta/meta.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  final ExpenseService expenseService;
  final IncomeService incomeService;
  final CategoryService categoryService;

  BottomSheetBloc(this.expenseService, this.incomeService, this.categoryService)
      : super(AddExpenseState()) {
    on<SaveExpenseDetailsEvent>((event, emit) async {
      emit(BottomSheetLoadingState());
      try {
        final response =
            await expenseService.addExpenseOfUser(event.expenseData);
        if (response != null) {
          await Future.delayed(const Duration(seconds: 1));

          emit(ExpenseAddedState(isSuccess: true, message: 'Expense Added'));
        } else {
          await Future.delayed(const Duration(seconds: 1));
          emit(ExpenseAddedState(
              isSuccess: false, message: 'Adding Expense Failed'));
        }
      } catch (e) {
        emit(ExpenseAddedState(
            isSuccess: false, message: 'Failed to add expense'));
      }
    });

    on<SaveIncomeDetailsEvent>((event, emit) async {
      emit(BottomSheetLoadingState());
      try {
        final response = await incomeService.addIncomeOfUser(event.incomeData);
        if (response != null) {
          await Future.delayed(const Duration(seconds: 1));

          emit(IncomeAddedState(isSuccess: true, message: 'Income Added'));
        } else {
          await Future.delayed(const Duration(seconds: 1));
          emit(IncomeAddedState(
              isSuccess: false, message: 'Adding Income Failed'));
        }
      } catch (e) {
        emit(IncomeAddedState(
            isSuccess: false, message: 'Failed to add income'));
      }
    });

    on<FetchCategoriesEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());
        try {
          final userId = AuthService().userID;
          await categoryService.fetchAndSetCategories(userId);
          await Future.delayed(const Duration(seconds: 1));

          emit(CategoryLoadedState(
              incomeCategories: CategoryService.incomeCategories,
              expenseCategories: CategoryService.expenseCategories));
          await categoryService.fetchAndSetCategoriesForDeletion(userId);
          await Future.delayed(const Duration(seconds: 1));

          emit(CategoryForDeletionLoadedState(
              incomeCategories: CategoryService.incomeCategoriesCanBeDeleted,
              expenseCategories: CategoryService.incomeCategoriesCanBeDeleted));
        } catch (e) {
          emit(CategoryErrorState(error: e.toString()));
        }
      },
    );

    on<AddCategoryEvent>((event, emit) async {
      emit(BottomSheetLoadingState());
      try {
        final response = await categoryService
            .addExpenseCategoryByUser(event.expeseCategoryData);
        if (response != null) {
          await Future.delayed(const Duration(seconds: 1));

          emit(ExpenseCategoryAddedState());
        }
      } catch (e) {
        print(e);
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      emit(BottomSheetLoadingState());
      try {
        final response = await categoryService.deleteCategory(event.categoryId);
        if (response != null) {
          await Future.delayed(const Duration(seconds: 1));

          emit(CategoryDeletedState());
        } else {}
      } catch (e) {
        print('error for deletion of category $e');
      }
    });
  }
}

class FontSizeBloc extends Bloc<FontSizeEvent, FontSizeState> {
  FontSizeBloc() : super(FontSizeState.initial()) {
    on<SelectExpense>((event, emit) {
      emit(FontSizeState(isExpenseSelected: true, isIncomeSelected: false));
    });

    on<SelectIncome>((event, emit) {
      emit(FontSizeState(isExpenseSelected: false, isIncomeSelected: true));
    });
  }
}
