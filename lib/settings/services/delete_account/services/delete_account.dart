// firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DeleteAccountService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> deleteAccount(String password) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Validate the password before proceeding
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);

        // Delete user from Authentication
        await user.delete();

        // Delete user data from Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete user data from Cloud Storage
        await _deleteUserDataFromStorage(user.uid);
      } else {
        // Handle the case when the user is not signed in
        throw Exception('User not signed in.');
      }
    } catch (e) {
      // Handle errors, e.g., if the password is incorrect
      throw Exception('Error deleting account: $e');
    }
  }

  Future<void> _deleteUserDataFromStorage(String userId) async {
    try {
      // Retrieve data from Firestore
      DocumentSnapshot userDataSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userDataSnapshot.exists) {
        // Explicitly cast the result to Map<String, dynamic>
        Map<String, dynamic>? userData =
            userDataSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          // Extract image URLs from Firestore
          List<String> imageUrls =
              List<String>.from(userData['imageUrls'] ?? <String>[]);

          // Delete images from Cloud Storage
          for (String imageUrl in imageUrls) {
            // Extract filename from URL
            String filename = imageUrl.split('/').last;
            // Delete file from Cloud Storage
            await _storage.ref('user_images/$userId/$filename').delete();
          }
        }
      }
    } catch (e) {
      // Handle errors, e.g., if there's an issue with Cloud Storage
      throw Exception('Error deleting user data from storage: $e');
    }
  }
}
