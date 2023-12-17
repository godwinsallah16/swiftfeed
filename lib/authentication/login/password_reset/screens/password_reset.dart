// password_reset_screen.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/password_reset/services/password_reset.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isCodeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_isCodeSent)
                Column(
                  children: [
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        labelText: 'Reset Code',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the reset code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the new password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isCodeSent ? _confirmPasswordReset : _sendResetCode,
                child: Text(
                    _isCodeSent ? 'Confirm Password Reset' : 'Send Reset Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendResetCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      await PasswordResetLogic.sendResetCode(_emailController.text);
      setState(() {
        _isCodeSent = true;
      });
    }
  }

  Future<void> _confirmPasswordReset() async {
    if (_formKey.currentState?.validate() ?? false) {
      await PasswordResetLogic.confirmPasswordReset(
        _codeController.text,
        _newPasswordController.text,
      );
      // Optionally, navigate to login screen or any other screen after successful password reset
    }
  }
}
