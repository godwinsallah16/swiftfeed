import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';

AnonUserModel convertUserToAnonModel(User firebaseUser) {
  return AnonUserModel(
    userId: firebaseUser.uid,
    isAnonymous: firebaseUser.isAnonymous,
    email: '', // Anonymous users don't have an email
  );
}
