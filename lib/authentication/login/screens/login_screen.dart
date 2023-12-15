// login_screen.dart

import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/forms/login_form.dart';
import 'package:swiftfeed/authentication/signup/forms/signup_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoginForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginForm ? 'Login' : 'Sign Up'), // Updated title
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: _isLoginForm
              ? const LoginForm()
              : const SignUpForm(), // Updated form name
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_isLoginForm
                  ? "Don't have an account? "
                  : "Already have an account? "),
              InkWell(
                onTap: () {
                  // Toggle between login and signup forms
                  setState(() {
                    _isLoginForm = !_isLoginForm;
                  });
                },
                child: Text(
                  _isLoginForm ? 'Sign Up' : 'Login',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
