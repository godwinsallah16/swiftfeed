// gmail_button.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/gmail/sign_in..dart';
import 'package:swiftfeed/utils/main_screen.dart';

class GmailButton extends StatelessWidget {
  const GmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var firebaseUser = await GoogleSignin().signInWithGoogle();

        if (firebaseUser != null) {
          // Sign-in successful, create EmailUserModel
          String username = firebaseUser.displayName ?? '';
          String email = firebaseUser.email ?? '';

          EmailUserModel emailUser = EmailUserModel(
            userId: firebaseUser.uid,
            email: email,
            username: username,
          );

          // Navigate to MainScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreen(emailUser: emailUser)),
          );
        } else {
          // Handle sign-in failure, display an error message if needed
          print('Sign-in with Google failed');
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/google_icon.png', // Replace with the actual path to your Google icon image
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          const Text('Login with Google'),
        ],
      ),
    );
  }
}
