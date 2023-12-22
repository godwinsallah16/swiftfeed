import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ProfileUpdateService {
  static Future<void> updateProfileImage(
      BuildContext context, User user, File imageFile) async {
    try {
      print('Uploading image to Firebase Storage...');

      // Upload image to Firebase Storage
      UploadTask task = FirebaseStorage.instance
          .ref('profile_images/${user.uid}.jpg')
          .putFile(imageFile);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      });

      await task;

      print('Image uploaded successfully.');

      // Get the download URL of the uploaded image
      String downloadURL = await FirebaseStorage.instance
          .ref('profile_images/${user.uid}.jpg')
          .getDownloadURL();

      print('Download URL: $downloadURL');

      // Update the profile image URL in the Firestore database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'profileImageURL': downloadURL});

      print('Profile image URL updated in Firestore.');
    } catch (e, stackTrace) {
      print('Error updating profile image: $e');
      print(stackTrace);
      rethrow; // Rethrow the error to handle it in the calling code
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
      if (profileImageURL != null) {
        updatedFields['profileImageURL'] = profileImageURL;
      }

      // Update the user's profile in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(updatedFields);
    } catch (e, stackTrace) {
      print('Error updating profile: $e');
      print(stackTrace);
      rethrow; // Rethrow the error to handle it in the calling code
    }
  }
}
