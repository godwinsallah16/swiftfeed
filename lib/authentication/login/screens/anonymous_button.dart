// anonymous_button.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anonymous_signin.dart';

class AnonymousButton extends StatefulWidget {
  const AnonymousButton({super.key});

  @override
  _AnonymousButtonState createState() => _AnonymousButtonState();
}

class _AnonymousButtonState extends State<AnonymousButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              AnonUserModel? user = await SignInAnonymous().signInAnonymously();

              setState(() {
                _isLoading = false;
              });

              if (user != null) {
                // If sign-in is successful, navigate to your existing MainScreen
                Navigator.pushReplacementNamed(context, '/main');
              } else {
                // Handle the case where anonymous sign-in failed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Anonymous sign-in failed'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0), // Adjust padding as needed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading)
            const CircularProgressIndicator()
          else
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.account_circle, color: Colors.white),
            ),
          const SizedBox(width: 10),
          const Text('Continue as Guest'),
        ],
      ),
    );
  }
}
