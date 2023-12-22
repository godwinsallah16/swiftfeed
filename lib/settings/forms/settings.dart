// settings_form.dart

import 'package:flutter/material.dart';
import 'package:swiftfeed/settings/services/logout/logout.dart';

import '../services/delete_account/screens/delete_account.dart';

class SettingsList extends StatelessWidget {
  final List<SettingsOption> settingsOptions = [
    SettingsOption(
      title: 'Account',
      description: 'Manage your account settings',
      onTap: (context) {
        // Handle tap on Account option
        print('Tapped on Account');
      },
      titleColor: Colors.black,
    ),
    SettingsOption(
      title: 'Notifications',
      description: 'Configure your notification preferences',
      onTap: (context) {
        // Handle tap on Notifications option
        print('Tapped on Notifications');
      },
      titleColor: Colors.black,
    ),
    SettingsOption(
      title: 'Privacy',
      description: 'Adjust your privacy settings',
      onTap: (context) {
        // Handle tap on Privacy option
        print('Tapped on Privacy');
      },
      titleColor: Colors.black,
    ),
    SettingsOption(
      title: 'Theme',
      description: 'Customize the app theme',
      onTap: (context) {
        // Handle tap on Theme option
        print('Tapped on Theme');
      },
      titleColor: Colors.black,
    ),
    SettingsOption(
      title: 'About',
      description: 'Learn more about the app',
      onTap: (context) {
        // Handle tap on About option
        print('Tapped on About');
      },
      titleColor: Colors.black,
    ),
    SettingsOption(
      title: 'Logout',
      description: 'Sign out of your account',
      onTap: (context) {
        LogoutFlowLogic.initiateLogout(context);
        print('Tapped on Logout');
      },
      titleColor: Colors.black,
    ),
    SettingsOption(
      title: 'Delete Account',
      description: 'Permanently delete your account',
      onTap: (context) {
        // Handle tap on Delete Account option
        showDialog(
          context: context,
          builder: (context) => DeleteAccountConfirmationDialog(
            onConfirm: () {
              // Handle confirmation
              Navigator.pushReplacementNamed(
                  context, '/login'); // Navigate to login screen
              print('Account deleted successfully.');
            },
          ),
        );
      },
      titleColor: Colors.red, // Set title color to red
    ),
    // Add more settings options as needed
  ];

  SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settingsOptions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            settingsOptions[index].title,
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the title bold
              color: settingsOptions[index].titleColor,
            ),
          ),
          subtitle: Text(settingsOptions[index].description),
          onTap: () {
            settingsOptions[index].onTap(context); // Pass context here
          },
        );
      },
    );
  }
}

class SettingsOption {
  final String title;
  final String description;
  final Function(BuildContext)
      onTap; // Use Function with BuildContext parameter
  final Color titleColor;

  SettingsOption({
    required this.title,
    required this.description,
    required this.onTap,
    required this.titleColor,
  });
}
