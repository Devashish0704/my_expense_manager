// auth_service.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';
import 'package:flutter_frontend/service/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final Dio _dio = DioClient.dio;

  int? userID;
  String? token;
  String? name;

  void logout(BuildContext context) {
    userID = null;
    token = null;
    name = null;
    context.read<HomeBloc>().add(ClearDataEvent());

    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (Route<dynamic> route) => false,
    );
  }

  Future<String?> login(Map<String, String> loginData) async {
    try {
      final response = await _dio.post('/login', data: loginData);
      if (response.statusCode == 200) {
        userID = response.data['id'];
        token = response.data['token'];
        name = response.data['name'];
        print('UserID after login: $userID');
        return response.statusMessage;
      } else {
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<String?> signup(Map<String, String> signUpData) async {
    try {
      final response = await _dio.post('/register', data: signUpData);
      if (response.statusCode == 201) {
        userID =
            response.data['id']; // Assuming you also return user ID upon signup
        token =
            response.data['token']; // Assuming you return a token upon signup
                    name = response.data['name'];

        return 'success'; // Return a success message or handle success in another way
      } else {
        return null; // Handle specific error cases if needed
      }
    } catch (e) {
      print('Sign up error: $e');
      return null; // Handle network or other errors
    }
  }

  Future<String?> signInWithGoogle(BuildContext context) async {
    try {
      // Check the platform and set the clientId accordingly
      String? clientId;
      if (kIsWeb) {
        clientId =
            '270134059657-d32lt6er302sloag7lb8b43kaf79noa0.apps.googleusercontent.com';
      } else if (Platform.isAndroid) {
        clientId =
            '270134059657-5oss2534oif90tsuph3vkpoeb64rlsnn.apps.googleusercontent.com';
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        clientId =
            '270134059657-9gmt3cqdqab8bfufebfs125ihird50gh.apps.googleusercontent.com';
      }

      GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: clientId,
        // serverClientId: clientId,
        scopes: ['email', 'profile'],
      );

      // Start the Google sign-in process
      print('Starting Google Sign-In...');
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print('Google Sign-In aborted by user.');
        _showDialog(
            context, 'Google Sign-In aborted', null, null, null, null, null);
        return 'Google Sign-In aborted';
      }

      // Obtain the auth details from the Google user
      print('Google Sign-In successful. Obtaining authentication details...');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      print('Access Token: $accessToken');
      print('ID Token: $idToken');

      // Send the Google token to your backend for verification
      print('Sending tokens to backend for verification...');
      final response = await _dio.post(
        '/auth/google/verify',
        data: {
          'access_token': accessToken,
          'id_token': idToken,
        },
      );

      print('Backend response status code: ${response.statusCode}');
      print('Backend response data: ${response.data}');

      if (response.statusCode == 200) {
        userID = response.data['id'];
        token = response.data['token'];
                name = response.data['name'];

        _showDialog(context, 'Sign-in successful', clientId, accessToken,
            idToken, userID.toString(), token);

        print('UserID after Google sign-in: $userID');
        return 'Sign-in successful';
      } else {
        print('Sign-in failed with status code: ${response.statusCode}');
        _showDialog(context, 'Sign-in failed', null, null, null, null, null);
        return 'Sign-in failed';
      }
    } catch (e) {
      print('Google sign-in error: $e');
      _showDialog(
          context, 'Google sign-in error: $e', null, null, null, null, null);
      return null;
    }
  }

  void _showDialog(BuildContext context, String message, String? clientId,
      String? accessToken, String? idToken, String? userID, String? token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Client ID: $clientId'),
                Text('Access Token: $accessToken'),
                Text('ID Token: $idToken'),
                Text('User ID: $userID'),
                Text('Token: $token'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<String?> signInWithGoogle() async {
  //   try {
  //     GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: ['email', 'profile'],
  //     );

  //     // Start the Google sign-in process
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     if (googleUser == null) {
  //       return 'Google Sign-In aborted';
  //     }

  //     // Obtain the auth details from the Google user
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final accessToken = googleAuth.accessToken;
  //     final idToken = googleAuth.idToken;

  //     // Send the Google token to your backend for verification
  //     final response = await _dio.post(
  //       '/auth/google/verify',
  //       data: {
  //         'access_token': accessToken,
  //         'id_token': idToken,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       userID = response.data['id'];
  //       token = response.data['token'];
  //       print('UserID after Google sign-in: $userID');
  //       return 'Sign-in successful';
  //     } else {
  //       return 'Sign-in failed';
  //     }
  //   } catch (e) {
  //     print('Google sign-in error: $e');
  //     return null;
  //   }
  // }
}
