// email_login_form.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/screens/login_button.dart';
import 'package:swiftfeed/authentication/login/password_reset/services/password_reset.dart';
import 'package:swiftfeed/authentication/login/services/login.dart';

class EmailUsernameForm extends StatefulWidget {
  const EmailUsernameForm({super.key});

  static void setError(BuildContext context, String errorMessage) {
    final formState = Form.of(context);
    (formState as _EmailUsernameFormState).setError(errorMessage);
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
  final bool _isLoading = false;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoginButton(
                emailController: _emailUsernameController,
                passwordController: _passwordController,
                onLogin: _login,
                isLoading: _isLoading,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_emailUsernameController.text.isNotEmpty) {
                    // Email is provided, initiate password reset
                    _initiatePasswordReset(_emailUsernameController.text);
                  } else {
                    // Show dialog for email input
                    _showEmailInputDialog(context);
                  }
                },
                child: const Text('Forgot Password'),
              ),
            ],
          )
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

  Future<void> _initiatePasswordReset(String email) async {
    try {
      await PasswordResetLogic.sendResetCode(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Check your inbox.'),
        ),
      );
    } on PasswordResetException catch (e) {
      setError(e.message);
    }
  }

  Future<void> _showEmailInputDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Forgot Password'),
          content: TextFormField(
            controller:
                _emailUsernameController, // Use the email controller here
            decoration: const InputDecoration(
              labelText: 'Enter your email',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Implement logic to handle the entered email
                  // For simplicity, I'm just printing it here
                  print('Entered email: ${_emailUsernameController.text}');
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emailUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
