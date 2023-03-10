import 'package:flutter/material.dart';

import 'package:flutter_course_beginner/constants/routes.dart';
import 'package:flutter_course_beginner/services/auth/auth_exceptions.dart';
import 'package:flutter_course_beginner/services/auth/auth_service.dart';
import 'package:flutter_course_beginner/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //'late' means the variable will have its value later
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register View'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );

                //final user = AuthService.firebase().currentUser;
                await AuthService.firebase().sendEmailVerification();

                Navigator.of(context).pushNamed(verifyEmailRoute);

                _email.clear();
                _password.clear();
              } on WeakPasswordAuthException {
                await showErrorDialog(context, "Weak Password");
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, "Email already taken");
              } on InvalidEmailAuthException {
                await showErrorDialog(context, "Invalid email");
              } on MissingEmailAuthException {
                await showErrorDialog(context, "Email field cannot be empty");
              } on GenericAuthException {
                await showErrorDialog(context, "Failed to register");
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already have an account? Sign in'),
          )
        ],
      ),
    );
  }
}
