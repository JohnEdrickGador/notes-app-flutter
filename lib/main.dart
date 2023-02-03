//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_course_beginner/firebase_options.dart';
import 'package:flutter_course_beginner/services/auth/auth_service.dart';

import 'views/login_view.dart';
import 'views/notes_view.dart';
import 'views/register_view.dart';
import 'views/verify_email_view.dart';
import 'constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: ((context) => const LoginView()),
        registerRoute: ((context) => const RegisterView()),
        notesRoute: ((context) => const NotesView()),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(), //from Auth Service
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              //check if user exists
              if (user.isEmailVerified) {
                return const NotesView(); //main UI of the application
              } else {
                return const VerifyEmailView();
              }
            } else {
              //if user does not exist or not logged in
              return const LoginView();
            }

          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
