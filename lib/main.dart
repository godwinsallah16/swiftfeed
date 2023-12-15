// main.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SwiftFeed',
      home: Splash(),
    );
  }
}
