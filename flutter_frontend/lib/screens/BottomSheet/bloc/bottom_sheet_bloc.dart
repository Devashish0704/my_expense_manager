import 'package:bloc/bloc.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/cat_service.dart';
import 'package:flutter_frontend/service/expense_service.dart';
import 'package:flutter_frontend/service/income_service.dart';
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
          emit(ExpenseAddedState(isSuccess: true, message: 'Expense Added'));
        } else {
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
          emit(IncomeAddedState(isSuccess: true, message: 'Income Added'));
        } else {
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
          emit(CategoryLoadedState(
              incomeCategories: CategoryService.incomeCategories,
              expenseCategories: CategoryService.expenseCategories));
          await categoryService.fetchAndSetCategoriesForDeletion(userId);
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
          emit(CategoryDeletedState());
        } else {}
      } catch (e) {
        print('error for deletion of category $e');
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
