// signup_form.dart

import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/screens/login_screen.dart'; // Import your login screen file
import 'package:swiftfeed/authentication/signup/forms/email_signup_validate.dart';
import 'package:swiftfeed/authentication/signup/services/email/sign_up.dart';
import 'package:swiftfeed/utils/main_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isUsernameValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to login screen when the user tries to go back
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        return false; // Prevents the default back navigation
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isUsernameValid ? Colors.blue : Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isUsernameValid ? Colors.blue : Colors.red,
                  ),
                ),
              ),
              validator: validateUsername,
              onChanged: (value) {
                setState(() {
                  _isUsernameValid =
                      value.isEmpty || validateUsername(value) == null;
                });
                _validateForm();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailValid ? Colors.blue : Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailValid ? Colors.blue : Colors.red,
                  ),
                ),
              ),
              validator: validateEmail,
              onChanged: (value) {
                setState(() {
                  _isEmailValid = value.isEmpty || validateEmail(value) == null;
                });
                _validateForm();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPasswordValid ? Colors.blue : Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPasswordValid ? Colors.blue : Colors.red,
                  ),
                ),
              ),
              validator: validatePassword,
              onChanged: (value) {
                setState(() {
                  _isPasswordValid =
                      value.isEmpty || validatePassword(value) == null;
                });
                _validateForm();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isConfirmPasswordValid ? Colors.blue : Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isConfirmPasswordValid ? Colors.blue : Colors.red,
                  ),
                ),
              ),
              validator: (value) => validateConfirmPassword(
                _passwordController.text,
                value,
              ),
              onChanged: (value) {
                setState(() {
                  _isConfirmPasswordValid = value.isEmpty ||
                      validateConfirmPassword(
                              _passwordController.text, value) ==
                          null;
                });
                _validateForm();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _validateForm();

                if (_isUsernameValid &&
                    _isEmailValid &&
                    _isPasswordValid &&
                    _isConfirmPasswordValid) {
                  String username = _usernameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  // Call the signup function
                  var firebaseUser =
                      await EmailSignup().signUpWithEmailAndPassword(
                    email,
                    password,
                    username,
                  );

                  if (firebaseUser != null) {
                    // Signup successful, navigate to MainScreen
                    EmailUserModel emailUser = EmailUserModel(
                      userId: firebaseUser.uid,
                      email: email,
                      username: username,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MainScreen(emailUser: emailUser)),
                    );
                  } else {
                    // Handle signup failure, display an error message if needed
                    print('Signup failed');
                  }
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _validateForm() {
    setState(() {
      _isEmailValid = _emailController.text.isEmpty ||
          validateEmail(_emailController.text) == null;
      _isPasswordValid = _passwordController.text.isEmpty ||
          validatePassword(_passwordController.text) == null;
      _isConfirmPasswordValid = _confirmPasswordController.text.isEmpty ||
          validateConfirmPassword(
                  _passwordController.text, _confirmPasswordController.text) ==
              null;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
