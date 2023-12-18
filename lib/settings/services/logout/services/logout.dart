// logout_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class LogoutService {
  static Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw 'An error occurred during logout. Please try again.';
    }
  }
}
