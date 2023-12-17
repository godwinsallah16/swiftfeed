// wrapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anon_user_converter.dart';
import 'package:swiftfeed/authentication/login/screens/login_screen.dart';
import 'package:swiftfeed/utils/main_screen.dart';

class Wrapper {
  static Future<Widget> initializeApp() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      User? firebaseUser = auth.currentUser;

      if (firebaseUser != null) {
        return determineScreen(firebaseUser);
      } else {
        return const LoginScreen();
      }
    } catch (e) {
      print('Error initializing app: $e');
      return const LoginScreen();
    }
  }

  static Future<Widget> determineScreen(User firebaseUser) async {
    // Determine the appropriate screen based on authentication status
    if (firebaseUser.isAnonymous) {
      return MainScreen(anonUser: convertUserToAnonModel(firebaseUser));
    } else {
      // Assume email user for now, modify as needed
      return MainScreen(
        emailUser: EmailUserModel(
          userId: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          username: firebaseUser.displayName ?? '',
        ),
      );
    }
  }
}
