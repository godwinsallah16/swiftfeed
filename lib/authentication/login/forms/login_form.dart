// login_form.dart

import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/forms/email_username_form.dart';
import 'package:swiftfeed/authentication/login/screens/anonymous_button.dart';
import 'package:swiftfeed/authentication/login/screens/gmail_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EmailUsernameForm(),
        SizedBox(height: 20),
        AnonymousButton(),
        SizedBox(height: 20),
        GmailButton(),
      ],
    );
  }
}
