// anonymous_button.dart

import 'package:flutter/material.dart';

class AnonymousButton extends StatelessWidget {
  const AnonymousButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle anonymous login and navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0), // Adjust padding as needed
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.account_circle, color: Colors.white),
          ),
          SizedBox(width: 10),
          Text('Continue as Guest'),
        ],
      ),
    );
  }
}
