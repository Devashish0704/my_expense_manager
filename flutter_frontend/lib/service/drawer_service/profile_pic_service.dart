import 'package:dio/dio.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/dio.dart';

class ProfilePicService {
  final Dio _dio = DioClient.dio;

  // Function to upload profile picture
  Future<String?> uploadUpdateProfilePic(Map<String, String> data) async {
    try {
      final response = await _dio.post(
        '/profile-image',
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer ${AuthService().token}'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['message']; // Adjust based on your API response
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Function to get profile picture
  Future<String?> getProfilePic(int? userId) async {
    try {
      final response = await _dio.get(
        '/profile-image/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer ${AuthService().token}'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['profile_image'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // Function to delete profile picture
  Future<String?> deleteProfilePic(int? userId) async {
    try {
      final response = await _dio.delete(
        '/profile-image/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer ${AuthService().token}'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
