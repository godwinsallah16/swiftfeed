import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/drawer/screens/drawer_header.dart';

class DrawerContentForm extends StatelessWidget {
  final EmailUserModel? emailUser;
  final AnonUserModel? anonUser;

  const DrawerContentForm({super.key, this.emailUser, this.anonUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          AccountDrawerHeader(
              emailUser: emailUser,
              anonUser: anonUser), // Include AccountDrawerHeader here
          ListTile(
            title: const Text('Sports'),
            onTap: () {
              // Navigate to the sports news screen or perform the desired action
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Entertainment'),
            onTap: () {
              // Navigate to the entertainment news screen or perform the desired action
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Business'),
            onTap: () {
              // Navigate to the business news screen or perform the desired action
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Politics'),
            onTap: () {
              // Navigate to the politics news screen or perform the desired action
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Foreign'),
            onTap: () {
              // Navigate to the foreign news screen or perform the desired action
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more list items for other news sections if needed
        ],
      ),
    );
  }
}
