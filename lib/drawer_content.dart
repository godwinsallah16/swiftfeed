// drawer_content.dart
import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountEmail: Text('godwinsallah16@gmail.com'),
            accountName: Text('godwinsallah'),
            currentAccountPicture: CircleAvatar(
              foregroundImage: AssetImage('assets/images/swift_logo.png'),
            ),
            otherAccountsPictures: [],
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Shop'),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text('Labels'),
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Green'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Red'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Blue'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
