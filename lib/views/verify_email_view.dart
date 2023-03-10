//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_beginner/constants/routes.dart';
import 'package:flutter_course_beginner/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email verification"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
                "Verification email sent! Please check your email to verify."),
            const Text("Haven't received it yet? press the button below"),
            TextButton(
              onPressed: () async {
                //final user = AuthService.firebase().currentUser;

                await AuthService.firebase().sendEmailVerification();

                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Resend verification'),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
