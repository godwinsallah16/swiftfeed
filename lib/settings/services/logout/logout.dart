// logout_flow_logic.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/settings/services/logout/screens/logout_confirmation.dart';
import 'package:swiftfeed/settings/services/logout/services/logout.dart';

class LogoutFlowLogic {
  static Future<void> initiateLogout(BuildContext context) async {
    bool confirmLogout = await showDialog(
      context: context,
      builder: (context) => LogoutConfirmationDialog(
        onConfirm: () async {
          Navigator.pop(context, true); // Close the dialog with confirmation
        },
      ),
    );

    if (confirmLogout == true) {
      // User confirmed logout
      try {
        await LogoutService.logout();
        // Update Firebase or perform any additional tasks after logout
        Navigator.pushReplacementNamed(
            context, '/login'); // Navigate to login screen
      } catch (e) {
        print('Error during logout: $e');
        // Handle error, e.g., show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }
}
