// login_button.dart
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool isLoading; // Add this line

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onLogin, // Disable button when loading
      child: isLoading
          ? const CircularProgressIndicator() // Show loading indicator
          : const Text('Login'),
    );
  }
}
