// gmail_button.dart
import 'package:flutter/material.dart';

class GmailButton extends StatelessWidget {
  const GmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle Gmail login and navigate to home screen
        Navigator.pushReplacementNamed(context, '/main');
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
