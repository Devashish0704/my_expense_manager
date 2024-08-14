// profile_pic_state.dart
part of 'profile_pic_bloc.dart';

@immutable
abstract class ProfilePicState {}

class ProfilePicInitial extends ProfilePicState {}

class ProfilePicLoading extends ProfilePicState {
  final Uint8List? previousImageBytes;

  ProfilePicLoading({this.previousImageBytes});
}

class ProfilePicLoaded extends ProfilePicState {
  final Uint8List imageBytes;

  ProfilePicLoaded(this.imageBytes);
}
class ProfilePicUpdated extends ProfilePicState {
  final Uint8List imageBytes;

  ProfilePicUpdated({required this.imageBytes});
}

class ProfilePicError extends ProfilePicState {
  final String errorMessage;
  ProfilePicError(this.errorMessage);
}

class ProfilePicDeleted extends ProfilePicState {}

