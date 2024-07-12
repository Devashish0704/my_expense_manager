import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/demo.dart';
import 'package:flutter_frontend/screens/Authorization/Phone%20Verification/bloc/phone_verification_bloc.dart';
import 'package:flutter_frontend/screens/Authorization/Phone%20Verification/phone_verification.dart';
import 'package:flutter_frontend/screens/BottomSheet/bloc/bottom_sheet_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/Budget/bloc/budget_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/Budget/budget.dart';
import 'package:flutter_frontend/screens/Drawer/Regular_Payment/bloc/category_bloc.dart';
import 'package:flutter_frontend/screens/Drawer/Regular_Payment/regular_payments.dart';
import 'package:flutter_frontend/screens/Drawer/bloc/regular_payment_bloc.dart';
import 'package:flutter_frontend/screens/Home/bloc/home_bloc.dart';
import 'package:flutter_frontend/screens/Authorization/LogIn/bloc/log_in_bloc.dart';
import 'package:flutter_frontend/screens/Authorization/SignUp/bloc/sign_up_bloc.dart';
import 'package:flutter_frontend/screens/Home/home.dart';
import 'package:flutter_frontend/screens/Authorization/LogIn/logIn.dart';
import 'package:flutter_frontend/screens/Authorization/SignUp/sign_up.dart';
import 'package:flutter_frontend/screens/stats.dart';
import 'package:flutter_frontend/screens/welcome.dart';
import 'package:flutter_frontend/service/auth_service.dart';
import 'package:flutter_frontend/service/budget_service.dart';
import 'package:flutter_frontend/service/cat_service.dart';
import 'package:flutter_frontend/service/dio.dart';
import 'package:flutter_frontend/service/expense_service.dart';
import 'package:flutter_frontend/service/income_service.dart';
import 'package:flutter_frontend/service/phone_verification_service.dart';
import 'package:flutter_frontend/service/regular_tranx_service.dart';

void main() {
  DioClient.setup();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(ExpenseService(), IncomeService(), AuthService())..add(ShowAllEvent()),
        ),
        BlocProvider<LogInBloc>(
          create: (context) => LogInBloc(AuthService()),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(AuthService()),
        ),
        BlocProvider<RegularPaymentBloc>(
          create: (context) => RegularPaymentBloc(RegularPaymentService(), AuthService()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider<BudgetBloc>(
          create: (context) => BudgetBloc(BudgetService(), AuthService()),
        ),
        BlocProvider<PhoneVerificationBloc>(
          create: (context) => PhoneVerificationBloc(PhoneVerificationService()),
        ),
        BlocProvider<BottomSheetBloc>(
            create: (context) => BottomSheetBloc(ExpenseService(), IncomeService(), CategoryService())),
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
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) =>  HomeScreen(),
        '/stats': (context) => const Stats(),
        '/demo': (context) => const Demo(),
        '/regular_payments': (context) => RegularPaymentScreen(),
        '/budget': (context) => Budget(),
        '/verify-phone': (context) => PhoneVerification()
      },
    );
  }
}


// {
//     "email": "ali@example.com",
//     "password": "pd71289"
// }