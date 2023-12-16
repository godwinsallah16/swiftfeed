// main_screen.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/bottom_navigator/tab_nav.dart';
import 'package:swiftfeed/home/screens/home.dart';
import 'package:swiftfeed/news/add_news/screens/add_news.dart';
import 'package:swiftfeed/news/bookmark/screens/bookmark.dart';
import 'package:swiftfeed/settings/screens/settings.dart';

class MainScreen extends StatelessWidget {
  final AnonUserModel? anonUser;
  final EmailUserModel? emailUser;

  MainScreen({super.key, this.anonUser, this.emailUser});

  final List<TabNavigatorItem> items = [
    TabNavigatorItem(
      page: const Home(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwiftFeed'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'User Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            if (anonUser != null)
              ListTile(
                title: Text('Username: ${anonUser!.userId}'),
                // Other details for anonymous user...
              ),
            if (emailUser != null)
              ListTile(
                title: Text('Email: ${emailUser!.email}'),
                subtitle: Text('Username: ${emailUser!.username}'),
                // Other details for email user...
              ),
          ],
        ),
      ),
      body: TabNavigator(items: items),
    );
  }
}
