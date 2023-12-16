import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anon_user_converter.dart';
import 'package:swiftfeed/authentication/login/screens/login_screen.dart';
import 'package:swiftfeed/main_screen.dart';
import 'package:swiftfeed/startapp/splash_screen.dart';
import 'package:swiftfeed/startapp/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftFeed',
      initialRoute: 'splash',
      routes: {
        '/': (context) => const Wrapper(),
        '/splash': (context) => const SplashScreen(),
        '/main': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as User?;
          // Check if user is not null before navigating to MainScreen
          return user != null
              ? MainScreen(user: convertUserToAnonModel(user))
              : const LoginScreen(); // Replace LoginScreen with your desired screen
        },
        // Add other routes as needed
      },
    );
  }
}
