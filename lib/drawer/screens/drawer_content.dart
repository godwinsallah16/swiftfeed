// drawer_content.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/drawer/user_account/user_info.dart';

class DrawerContent extends StatelessWidget {
  final AnonUserModel user; // Add user parameter

  const DrawerContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserInfo(
              user: user), // Display user information using UserInfo widget
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
