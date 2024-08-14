part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<Map<String, dynamic>> combinedList;

  HomeLoadedState({required this.combinedList});
}

final class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}


final class ExpenseUpdatedState extends HomeState {}