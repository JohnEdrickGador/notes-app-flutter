import 'package:flutter_course_beginner/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser; //optionally return the current user

  Future<void> initialize();

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();
}
