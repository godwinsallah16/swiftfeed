// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anonymous_signin.dart';
import 'package:swiftfeed/base_screen.dart';
import 'package:swiftfeed/firebase_options.dart';
import 'package:swiftfeed/home/screens/home.dart';
import 'package:swiftfeed/news/add_news/screens/add_news.dart';
import 'package:swiftfeed/news/bookmark/screens/bookmark.dart';
import 'package:swiftfeed/settings/screens/settings.dart';
import 'package:swiftfeed/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AnonUserModel? user = await SignInAnonymous().signInAnonymously();

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final AnonUserModel? user;

  const MyApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftFeed',
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/main': (context) => MainScreen(
            user: user ?? AnonUserModel(userId: '', isAnonymous: true)),
        '/home': (context) => const Home(),
        '/add': (context) => const AddNewsScreen(),
        '/bookmark': (context) => const BookmarkScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
