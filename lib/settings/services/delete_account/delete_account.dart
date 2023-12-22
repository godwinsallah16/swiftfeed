// delete_account_logic.dart

import 'package:swiftfeed/settings/services/delete_account/services/delete_account.dart';

class DeleteAccountLogic {
  final DeleteAccountService _firebaseService = DeleteAccountService();

  Future<void> deleteAccount(String password) async {
    try {
      await _firebaseService.deleteAccount(password);
    } catch (e) {
      // Handle errors, e.g., display an error dialog
      // You can add more specific error handling here
      _showErrorDialog('Error deleting account: $e');
    }
  }

  void _showErrorDialog(String message) {
    // Logic to show error dialog can be added here
  }
}
