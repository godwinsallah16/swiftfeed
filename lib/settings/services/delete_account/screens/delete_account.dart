// delete_account_ui.dart
import 'package:flutter/material.dart';

import '../delete_account.dart';

class DeleteAccountConfirmationDialog extends StatefulWidget {
  final VoidCallback onConfirm;

  const DeleteAccountConfirmationDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  _DeleteAccountConfirmationDialogState createState() =>
      _DeleteAccountConfirmationDialogState();
}

class _DeleteAccountConfirmationDialogState
    extends State<DeleteAccountConfirmationDialog> {
  final TextEditingController _passwordController = TextEditingController();
  final DeleteAccountLogic _logic = DeleteAccountLogic();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: Column(
        children: [
          const Text('Are you sure you want to delete this account?'),
          const SizedBox(height: 10),
          const Text(
            'This action will permanently delete your account and all associated data.',
            style: TextStyle(color: Colors.red),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Validate the password
            if (_validatePassword()) {
              // If password is valid, proceed with account deletion
              await _logic.deleteAccount(_passwordController.text.trim());
              Navigator.pop(context); // Close the dialog
              // Call the callback provided in the constructor
              widget.onConfirm();
            }
          },
          child:
              const Text('Delete Account', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  bool _validatePassword() {
    String password = _passwordController.text.trim();
    if (password.length < 6) {
      _showErrorDialog('Password must be at least 6 characters long.');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the error dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
