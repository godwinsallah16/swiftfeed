// tab_navigator.dart

import 'package:flutter/material.dart';

class TabNavigatorItem {
  final Widget page;
  final BottomNavigationBarItem item;
  final String title;

  TabNavigatorItem({
    required this.page,
    required this.item,
    required this.title,
  });
}

class TabNavigator extends StatefulWidget {
  final List<TabNavigatorItem> items;
  final Function(int) onTabChanged;

  const TabNavigator({
    super.key,
    required this.items,
    required this.onTabChanged,
  });

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
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        items: widget.items.map((item) => item.item).toList(),
        currentIndex: _currentIndex,
        onTap: (index) {
          widget.onTabChanged(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
