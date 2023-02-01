import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_course_beginner/firebase_options.dart';

import 'views/login_view.dart';
import 'views/register_view.dart';
import 'views/verify_email_view.dart';

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
        '/login/': ((context) => const LoginView()),
        '/register/': ((context) => const RegisterView()),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              //check if user exists
              if (user.emailVerified) {
                print("Email is verified");
              } else {
                return const VerifyEmailView();
              }
            } else {
              //if user does not exist or not logged in
              return const LoginView();
            }
            return const Text("Done");
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
