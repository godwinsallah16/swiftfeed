import 'package:firebase_auth/firebase_auth.dart';

class AnonymousSignin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnon() async {
    try {
      return (await _auth.signInAnonymously()).user;
    } catch (e) {
      print('Error signing in anonymously: $e');
      return null;
    }
  }
}
