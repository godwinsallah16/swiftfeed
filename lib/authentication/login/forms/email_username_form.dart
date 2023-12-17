// email_username_form.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/screens/login_button.dart';
import 'package:swiftfeed/authentication/login/services/login.dart';

class EmailUsernameForm extends StatefulWidget {
  const EmailUsernameForm({super.key});

  static void setError(BuildContext context, String errorMessage) {
    final _formState = Form.of(context);
    (_formState as _EmailUsernameFormState).setError(errorMessage);
  }

  @override
  _EmailUsernameFormState createState() => _EmailUsernameFormState();
}

class _EmailUsernameFormState extends State<EmailUsernameForm> {
  final TextEditingController _emailUsernameController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  String _errorMessage = '';

  void setError(String errorMessage) {
    setState(() {
      _errorMessage = errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Email/Username',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: _emailUsernameController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your email or username';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Text(
            _errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 10),
          LoginButton(
            emailController: _emailUsernameController,
            passwordController: _passwordController,
            onLogin: _login,
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    try {
      User? user = await LoginServices().loginWithEmailAndPassword(
        _emailUsernameController.text,
        _passwordController.text,
      );

      if (user != null) {
        // Successfully logged in, navigate to MainScreen
        Navigator.pushReplacementNamed(context, '/', arguments: user);
      } else {
        // Handle null user (shouldn't happen in normal cases)
        print('Login failed. User is null.');
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException and set error message
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        setError('Incorrect email or password');
      } else {
        // Handle other FirebaseAuthException errors
        setError('Login failed. ${e.message}');
      }
    } catch (e) {
      // Handle other exceptions
      setError('Login failed. $e');
    }
  }

  @override
  void dispose() {
    _emailUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
