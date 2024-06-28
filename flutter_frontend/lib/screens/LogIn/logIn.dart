import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/LogIn/bloc/log_in_bloc.dart';
import 'package:flutter_frontend/screens/SignUp/sign_up.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Log In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            BlocBuilder<LogInBloc, LogInState>(
              builder: (context, state) {
                if (state is LogInErrorState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(fontSize: 10, color: Colors.red),
                  );
                } else {
                  return Container();
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
              onChanged: (val) {
                BlocProvider.of<LogInBloc>(context).add(LogInTextChangeEvent(
                    emailValue: emailController.text,
                    passwordValue: passwordController.text));
              },
            ),
            TextFormField(
              onChanged: (val) {
                BlocProvider.of<LogInBloc>(context).add(LogInTextChangeEvent(
                    emailValue: emailController.text,
                    passwordValue: passwordController.text));
              },
              decoration: const InputDecoration(labelText: 'Password'),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Forgot password logic
              },
              child: const Text('Forgot Password?'),
            ),
            const SizedBox(height: 20),
            BlocConsumer<LogInBloc, LogInState>(
              listener: (context, state) {
                if (state is LogInFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                } else if (state is LogInSuccessState) {
                  Navigator.pushNamed(context, '/home');
                  print(emailController.text + passwordController.text);
                }
              },
              builder: (context, state) {
                if (state is LogInLoadingState) {
                  return const CircularProgressIndicator();
                }
                return CupertinoButton(
                  color: (state is LogInValidState)
                      ? Colors.redAccent
                      : Colors.grey,
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (state is LogInValidState) {
                      BlocProvider.of<LogInBloc>(context).add(
                          LogInSubmittedEvent(
                              email: email, password: password));
                    }
                  },
                  child: const Text('Log In'),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
