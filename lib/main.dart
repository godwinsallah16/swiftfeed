// main.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/base_screen.dart';
import 'package:swiftfeed/home/screens/home.dart';
import 'package:swiftfeed/news/add_news/screens/add_news.dart';
import 'package:swiftfeed/news/bookmark/screens/bookmark.dart';
import 'package:swiftfeed/settings/screens/settings.dart';
import 'package:swiftfeed/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftFeed',
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/main': (context) => MainScreen(),
        '/home': (context) => const Home(),
        '/add': (context) => const AddNewsScreen(),
        '/bookmark': (context) => const BookmarkScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
