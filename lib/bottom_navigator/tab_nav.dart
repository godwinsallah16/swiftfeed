// tab_navigator.dart
import 'package:flutter/material.dart';

class TabNavigatorItem {
  final Widget page;
  final BottomNavigationBarItem item;

  TabNavigatorItem({required this.page, required this.item});
}

class TabNavigator extends StatefulWidget {
  final List<TabNavigatorItem> items;

  const TabNavigator({super.key, required this.items});

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.items[_currentIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey, // Set the selected item color
        unselectedItemColor: Colors.white,
        items: widget.items.map((item) => item.item).toList(),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
