// login_screen.dart

import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/forms/login_form.dart';
import 'package:swiftfeed/authentication/signup/forms/signup_form.dart';
import 'package:swiftfeed/utils/quit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoginForm = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If in signup form, switch to login form
        if (!_isLoginForm) {
          setState(() {
            _isLoginForm = true;
          });
          return false;
        }

        // Show a confirmation dialog when the user presses the back button
        bool exit = await showExitConfirmationDialog(context);
        if (exit) {
          // Close all screens when the user confirms exit
          closeApp();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:
              !_isLoginForm, // Show back arrow if not in login form
          title: Text(_isLoginForm ? 'Login' : 'Sign Up'),
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
                Text(
                  _isLoginForm
                      ? "Don't have an account? "
                      : "Already have an account? ",
                ),
                InkWell(
                  onTap: () {
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
      ),
    );
  }

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you really want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    // Close all screens when the user confirms exit
                    closeApp();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
