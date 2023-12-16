// main_screen.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/bottom_navigator/tab_nav.dart';
import 'package:swiftfeed/home/screens/home.dart';
import 'package:swiftfeed/news/add_news/screens/add_news.dart';
import 'package:swiftfeed/news/bookmark/screens/bookmark.dart';
import 'package:swiftfeed/settings/screens/settings.dart';

import 'authentication/login/anon_login/models/anon_user_model.dart';

class MainScreen extends StatelessWidget {
  final AnonUserModel user; // Add user argument

  MainScreen({super.key, required this.user});

  final List<TabNavigatorItem> items = [
    TabNavigatorItem(
      page: const Home(), // Pass the user argument to Home directly
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.home),
        label: 'Home',
      ),
    ),
    TabNavigatorItem(
      page: const AddNewsScreen(),
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.add),
        label: 'Add',
      ),
    ),
    TabNavigatorItem(
      page: const BookmarkScreen(),
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.bookmark),
        label: 'Bookmark',
      ),
    ),
    TabNavigatorItem(
      page: const SettingsScreen(),
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return TabNavigator(items: items);
  }
}
