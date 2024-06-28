import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/screens/LogIn/logIn.dart';
import 'package:flutter_frontend/screens/SignUp/bloc/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController fullNameSignUpController =
      TextEditingController();
  final TextEditingController emailSignUpController = TextEditingController();
  final TextEditingController passwordSignUpController =
      TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                if (state is SignUpErrorState) {
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
              decoration: const InputDecoration(labelText: 'Full Name'),
              controller: fullNameSignUpController,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailSignUpController,
              onChanged: (val) {
                BlocProvider.of<SignUpBloc>(context).add(SignUpTextChangeEvent(
                    emailValue: emailSignUpController.text,
                    passwordValue: passwordSignUpController.text,
                    fullnameValue: fullNameSignUpController.text));
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              controller: passwordSignUpController,
              onChanged: (val) {
                BlocProvider.of<SignUpBloc>(context).add(SignUpTextChangeEvent(
                    emailValue: emailSignUpController.text,
                    passwordValue: passwordSignUpController.text,
                    fullnameValue: fullNameSignUpController.text));
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Verify your phone number if you want:',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                } else if (state is SignUpSuccessState) {
                  Navigator.pushNamed(context, '/home');
                }
              },
              builder: (context, state) {
                if (state is SignUpLoadingState) {
                  return const CircularProgressIndicator();
                }
                return CupertinoButton(
                  color: (state is SignUpValidState)
                      ? Colors.redAccent
                      : Colors.grey,
                  onPressed: () async {
                    // Sign up logic here
                    String email = emailSignUpController.text;
                    String fullName = fullNameSignUpController.text;
                    String password = passwordSignUpController.text;

                    if (state is SignUpValidState) {
                      BlocProvider.of<SignUpBloc>(context).add(
                          SignUpSubmittedEvent(
                              fullname: fullName,
                              email: email,
                              password: password));
                    }
                  },
                  child: const Text('Sign Up'),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text('Log In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
