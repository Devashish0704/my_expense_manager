part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class LoadExpenseCategoriesEvent extends CategoryEvent {}

class LoadIncomeCategoriesEvent extends CategoryEvent {}

class SelectUnlimitedEvent extends CategoryEvent {}

class SelectCustomizeEvent extends CategoryEvent {}