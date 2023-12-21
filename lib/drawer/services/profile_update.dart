import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileUpdateService {
  static Future<void> updateProfileImage(File imageFile) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Upload image to Firebase Storage
        await FirebaseStorage.instance
            .ref('profile_images/${user.uid}.jpg')
            .putFile(imageFile);

        // Get the download URL of the uploaded image
        String downloadURL = await FirebaseStorage.instance
            .ref('profile_images/${user.uid}.jpg')
            .getDownloadURL();

        // Update the profile image URL in the Firestore database
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profileImageURL': downloadURL});
      } catch (e) {
        print('Error updating profile image: $e');
        rethrow; // Rethrow the error to handle it in the calling code
      }
    }
  }

  static Future<void> updateProfile({
    required String userId,
    String? username,
    String? email,
    String? profileImageURL,
  }) async {
    try {
      // Create a map of updated fields
      Map<String, dynamic> updatedFields = {};
      if (username != null) updatedFields['username'] = username;
      if (email != null) updatedFields['email'] = email;
      if (profileImageURL != null)
        updatedFields['profileImageURL'] = profileImageURL;

      // Update the user's profile in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(updatedFields);
    } catch (e) {
      print('Error updating profile: $e');
      rethrow; // Rethrow the error to handle it in the calling code
    }
  }
}
