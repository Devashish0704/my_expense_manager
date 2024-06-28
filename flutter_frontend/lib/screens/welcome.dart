import 'package:flutter/material.dart';
import 'package:flutter_frontend/constants.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to Expense Manager',
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                  // Navigate to Sign Up screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryAccentColor, // Background color
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');

                  // Navigate to Log In screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryAccentColor, // Background color
                ),
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
