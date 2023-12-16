import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anon_user_converter.dart';
import 'package:swiftfeed/authentication/login/screens/login_screen.dart';
import 'package:swiftfeed/main_screen.dart';
import 'package:swiftfeed/startapp/splash_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      await Firebase.initializeApp();
      FirebaseAuth auth = FirebaseAuth.instance;

      User? firebaseUser = auth.currentUser;

      if (mounted) {
        if (firebaseUser != null) {
          AnonUserModel user = convertUserToAnonModel(firebaseUser);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreen(user: user)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      }

      auth.authStateChanges().listen((User? firebaseUser) {
        if (mounted) {
          Future.delayed(const Duration(seconds: 2), () {
            if (firebaseUser != null) {
              AnonUserModel user = convertUserToAnonModel(firebaseUser);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainScreen(user: user)),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            }
          });
        }
      });
    } catch (e) {
      print('Error initializing app: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isInitialized ? const SplashScreen() : Container(),
    );
  }
}
