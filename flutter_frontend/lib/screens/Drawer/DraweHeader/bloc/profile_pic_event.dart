// profile_pic_event.dart
part of 'profile_pic_bloc.dart';

@immutable
abstract class ProfilePicEvent {}

class PickImageEvent extends ProfilePicEvent {}

class UploadUpdateImageEvent extends ProfilePicEvent {
  final String base64Image;
  UploadUpdateImageEvent(this.base64Image);
}

class GetImageEvent extends ProfilePicEvent {}

class DeleteImageEvent extends ProfilePicEvent {}

