// main_screen.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/bottom_navigator/tab_nav.dart';
import 'package:swiftfeed/home/screens/home.dart';
import 'package:swiftfeed/news/add_news/screens/add_news.dart';
import 'package:swiftfeed/news/bookmark/screens/bookmark.dart';
import 'package:swiftfeed/settings/screens/settings.dart';

class MainScreen extends StatefulWidget {
  final AnonUserModel? anonUser;
  final EmailUserModel? emailUser;

  const MainScreen({Key? key, this.anonUser, this.emailUser}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<TabNavigatorItem> _tabItems = [
    TabNavigatorItem(
      page: const Home(),
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      title: 'Home',
    ),
    TabNavigatorItem(
      page: const AddNewsScreen(),
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.add),
        label: 'Add',
      ),
      title: 'Add News',
    ),
    TabNavigatorItem(
      page: const BookmarkScreen(),
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.bookmark),
        label: 'Bookmark',
      ),
      title: 'Bookmark',
    ),
    TabNavigatorItem(
      page: const SettingsScreen(),
      item: const BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
      title: 'Settings',
    ),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabItems[_currentIndex].title),
        backgroundColor: Colors.grey[100],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
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
            if (widget.anonUser != null)
              ListTile(
                title: Text('Username: ${widget.anonUser!.userId}'),
              ),
            if (widget.emailUser != null)
              ListTile(
                title: Text('Email: ${widget.emailUser!.email}'),
                subtitle: Text('Username: ${widget.emailUser!.username}'),
              ),
          ],
        ),
      ),
      body: TabNavigator(
        items: _tabItems,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}
