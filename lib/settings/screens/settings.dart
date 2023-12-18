import 'package:flutter/material.dart';
import 'package:swiftfeed/settings/forms/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SettingsList(),
      ),
    );
  }
}
