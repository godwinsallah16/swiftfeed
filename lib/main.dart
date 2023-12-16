import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anon_user_converter.dart';
import 'package:swiftfeed/authentication/login/screens/login_screen.dart';
import 'package:swiftfeed/main_screen.dart';
import 'package:swiftfeed/startapp/splash_screen.dart';
import 'package:swiftfeed/startapp/wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftFeed',
      initialRoute: '/splash',
      routes: {
        '/': (context) => const Wrapper(),
        '/splash': (context) => const SplashScreen(),
        '/main': (context) {
          final user = ModalRoute.of(context)?.settings.arguments as User?;
          if (user != null) {
            if (user.isAnonymous) {
              return MainScreen(anonUser: convertUserToAnonModel(user));
            } else {
              // Replace with your logic to fetch additional details for email user
              final emailUser = EmailUserModel(
                userId: user.uid,
                email: user.email ?? '',
                username: '', // Add username if available
              );

              return MainScreen(emailUser: emailUser);
            }
          } else {
            return const LoginScreen();
          }
        },
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      },
    );
  }
}
