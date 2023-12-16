// signup_form.dart

import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/signup/forms/email_signup_validate.dart';
import 'package:swiftfeed/authentication/signup/services/email/sign_up.dart';
import 'package:swiftfeed/main_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
            validator: validateUsername,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: validateEmail,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            validator: validatePassword,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(),
            ),
            validator: (value) => validateConfirmPassword(
              _passwordController.text,
              value,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
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
    );
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
