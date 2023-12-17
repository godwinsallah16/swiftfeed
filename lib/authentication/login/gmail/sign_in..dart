import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential authResult =
            await _auth.signInWithCredential(credential);
        User? user = authResult.user;

        if (user != null) {
          print('User signed in: ${user.displayName}');
          // Perform further actions, e.g., navigate to the next screen
        }

        return user;
      } else {
        return null; // User canceled the sign-in
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
