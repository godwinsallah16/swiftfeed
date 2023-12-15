// email_username_form.dart

import 'package:flutter/material.dart';

class EmailUsernameForm extends StatefulWidget {
  const EmailUsernameForm({super.key});

  @override
  _EmailUsernameFormState createState() => _EmailUsernameFormState();
}

class _EmailUsernameFormState extends State<EmailUsernameForm> {
  final TextEditingController _emailUsernameController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

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
              hintText: 'Enter your email or username',
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Form is valid, perform login logic
                Navigator.pushReplacementNamed(context, '/main');
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
