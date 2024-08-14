// profile_pic_bloc.dart
import 'dart:convert';
import 'dart:io' as io;
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/drawer_service/profile_pic_service.dart';

part 'profile_pic_event.dart';
part 'profile_pic_state.dart';

class ProfilePicBloc extends Bloc<ProfilePicEvent, ProfilePicState> {
  final ProfilePicService profilePicService;
  final AuthService authService;

  ProfilePicBloc(this.profilePicService, this.authService)
      : super(ProfilePicInitial()) {
    on<PickImageEvent>(_onPickImageEvent);
    on<UploadUpdateImageEvent>(_onUploadUpdateImageEvent);
    on<GetImageEvent>(_onGetImageEvent);

    on<DeleteImageEvent>((event, emit) async {
      emit(ProfilePicLoading());

      try {
        // Assume the profilePicService has a deleteProfilePic method
        await profilePicService.deleteProfilePic(authService.userID);
        emit(ProfilePicDeleted());
      } catch (e) {
        emit(ProfilePicError('Failed to delete profile picture: $e'));
      }
    });
  }

  Future<void> _onPickImageEvent(
      PickImageEvent event, Emitter<ProfilePicState> emit) async {
    // Temporary state to indicate loading but preserve the current image if any
    if (state is ProfilePicLoaded) {
      emit(ProfilePicLoading(
          previousImageBytes: (state as ProfilePicLoaded).imageBytes));
    } else {
      emit(ProfilePicLoading());
    }

    XFile? image;
    Uint8List? imageBytes;
    String? base64Image;

    try {
      if (kIsWeb) {
        final result =
            await FilePicker.platform.pickFiles(type: FileType.image);

        if (result != null && result.files.single.bytes != null) {
          imageBytes = result.files.single.bytes;
          base64Image = base64Encode(imageBytes!);
        } else {
          emit(state); // Emit the previous state if no image is selected
          return;
        }
      } else if (io.Platform.isAndroid || io.Platform.isIOS) {
        final picker = ImagePicker();
        image = await picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          imageBytes = await image.readAsBytes();
          base64Image = base64Encode(imageBytes);
        } else {
          emit(state); // Emit the previous state if no image is selected
          return;
        }
      }

      if (base64Image != null) {
        emit(ProfilePicLoaded(imageBytes!));
        add(UploadUpdateImageEvent(base64Image));
      }
    } catch (e) {
      emit(ProfilePicError(e.toString()));
    }
  }

  Future<void> _onUploadUpdateImageEvent(
      UploadUpdateImageEvent event, Emitter<ProfilePicState> emit) async {
    emit(ProfilePicLoading());

    try {
      final Map<String, String> data = {
        'userId': authService.userID.toString(),
        'base64Image': event.base64Image,
      };

      print('Uploading image...');
      final responseMessage =
          await profilePicService.uploadUpdateProfilePic(data);
      print('Upload response: $responseMessage');
      if (responseMessage != null) {
        print('Image uploaded successfully');
        emit(ProfilePicLoaded(base64Decode(event.base64Image)));
        // Add GetImageEvent to fetch the latest profile picture after update
        add(GetImageEvent());
      } else {
        print('Failed to upload/update profile picture');
        emit(ProfilePicError('Failed to upload/update profile picture'));
      }
    } catch (e) {
      print('Upload error: $e');
      emit(ProfilePicError(e.toString()));
    }
  }

  Future<void> _onGetImageEvent(
      GetImageEvent event, Emitter<ProfilePicState> emit) async {
    emit(ProfilePicLoading());

    try {
      final imageBase64 =
          await profilePicService.getProfilePic(authService.userID);
      if (imageBase64 != null) {
        emit(ProfilePicLoaded(base64Decode(imageBase64)));
      } else {
        emit(ProfilePicError('No profile picture found'));
      }
    } catch (e) {
      emit(ProfilePicError('Failed to fetch profile picture: $e'));
    }
  }
}
