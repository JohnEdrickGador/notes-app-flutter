import 'package:flutter_course_beginner/services/auth/auth_provider.dart'; //we need this because this will serve as the template for firebase auth provider
import 'package:flutter_course_beginner/services/auth/auth_user.dart'; //we need this since auth_provider.dart methods return auth_user
import 'package:flutter_course_beginner/services/auth/auth_exceptions.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    //implement createUser
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw WeakPasswordAuthException();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else if (e.code == "missing-email") {
        throw MissingEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  //implement currentUser
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    //implement logIn
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw UserNotFoundAuthException();
      } else if (e.code == "wrong-password") {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    //implement logOut
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    //implement sendEmailVerification
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
