// anonymous_signin.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';

class SignInAnonymous {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AnonUserModel?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        return AnonUserModel(userId: user.uid, isAnonymous: user.isAnonymous);
      }
    } catch (e) {
      print('Error signing in anonymously: $e');
    }

    return null;
  }
}
