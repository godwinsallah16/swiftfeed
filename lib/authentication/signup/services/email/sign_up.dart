// email_signup.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailSignup {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name with the provided username
      await result.user!.updateDisplayName(username);

      // Store user details in Firestore
      await _firestore.collection('users').doc(result.user!.uid).set({
        'username': username,
        'email': email,
        // Add more fields as needed
      });

      // Fetch the updated user information
      User? updatedUser = _auth.currentUser;

      return updatedUser;
    } catch (e) {
      // print('Error signing up with email and password: $e');
      return null;
    }
  }
}
