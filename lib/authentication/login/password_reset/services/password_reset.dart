// password_reset.dart
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetLogic {
  static Future<void> sendResetCode(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Throw a more descriptive exception
      throw PasswordResetException('Failed to send reset code. $e');
    }
  }

  static Future<void> confirmPasswordReset(
      String code, String newPassword) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
    } catch (e) {
      // Throw a more descriptive exception
      throw PasswordResetException('Failed to confirm password reset. $e');
    }
  }
}

class PasswordResetException implements Exception {
  final String message;

  PasswordResetException(this.message);

  @override
  String toString() {
    return 'PasswordResetException: $message';
  }
}
