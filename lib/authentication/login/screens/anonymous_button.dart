import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anonymous_signin.dart';
import 'package:swiftfeed/main_screen.dart';

class AnonymousButton extends StatefulWidget {
  const AnonymousButton({super.key});

  @override
  _AnonymousButtonState createState() => _AnonymousButtonState();
}

class _AnonymousButtonState extends State<AnonymousButton> {
  final AnonymousSignin _auth = AnonymousSignin();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signInAnonymously,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0), // Adjust padding as needed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading)
            const CircularProgressIndicator()
          else
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.account_circle, color: Colors.white),
            ),
          const SizedBox(width: 10),
          const Text('Continue as Guest'),
        ],
      ),
    );
  }

  Future<void> _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var firebaseUser = await _auth.signInAnon();

      if (firebaseUser != null) {
        _handleSignInSuccess(firebaseUser);
      } else {
        _handleSignInError();
      }
    } catch (e, stackTrace) {
      print('Error signing in anonymously: $e');
      print('Stack Trace: $stackTrace');
      _handleSignInError();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSignInSuccess(User firebaseUser) {
    AnonUserModel user = AnonUserModel(
      userId: firebaseUser.uid,
      isAnonymous: firebaseUser.isAnonymous,
      email: '', // Anonymous users don't have an email
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainScreen(user: user)),
    );
  }

  void _handleSignInError() {
    print('Error signing in anonymously');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Anonymous sign-in failed'),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
