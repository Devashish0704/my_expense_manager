import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/demo.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';
import 'package:flutter_frontend/screens/LogIn/bloc/log_in_bloc.dart';
import 'package:flutter_frontend/screens/SignUp/bloc/sign_up_bloc.dart';
import 'package:flutter_frontend/screens/Home/home.dart';
import 'package:flutter_frontend/screens/LogIn/logIn.dart';
import 'package:flutter_frontend/screens/SignUp/sign_up.dart';
import 'package:flutter_frontend/screens/stats.dart';
import 'package:flutter_frontend/screens/welcome.dart';
import 'package:flutter_frontend/service/auth_service.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(AuthService())..add(ShowAllEvent()),
        ),
        BlocProvider<LogInBloc>(
          create: (context) => LogInBloc(AuthService()),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(AuthService()),
        ),
        BlocProvider<BottomSheetBloc>(
          create: (context) => BottomSheetBloc(AuthService())
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense Manager',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Color(0xFFB0BEC5)), // Light Gray
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF00BCD4),
          textTheme: ButtonTextTheme.primary,
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
       initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) =>  LoginScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/stats': (context) => const Stats(),
        '/demo': (context) => const Demo(),
       },
    );
  }
}



// {
//     "email": "ali@example.com",
//     "password": "pd71289"
// }