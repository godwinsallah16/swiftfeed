import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/services/anon_user_converter.dart';
import 'package:swiftfeed/authentication/login/screens/login_screen.dart';
import 'package:swiftfeed/utils/main_screen.dart';

class Wrapper {
  static Future<Widget> initializeApp() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      User? firebaseUser = auth.currentUser;

      if (firebaseUser != null) {
        return determineScreen(firebaseUser);
      } else {
        return const LoginScreen();
      }
    } catch (e) {
      // Handle initialization error
      return const LoginScreen();
    }
  }

  static Future<Widget> determineScreen(User firebaseUser) async {
    if (firebaseUser.isAnonymous) {
      return MainScreen(anonUser: convertUserToAnonModel(firebaseUser));
    } else {
      // Retrieve additional user data (e.g., profileImageURL) from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null) {
        // Assume email user for now, modify as needed
        String profileImageURL = userData['profileImageURL'] ?? '';

        // Check if the profile image is already in cache
        if (!ImageCache().containsKey(profileImageURL)) {
          // If not in cache, download and precache the image
          CachedNetworkImageProvider(profileImageURL)
              .resolve(const ImageConfiguration());
        }

        return MainScreen(
          emailUser: EmailUserModel(
            userId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            username: firebaseUser.displayName ?? '',
            profileImageURL: profileImageURL,
          ),
        );
      } else {
        // Handle case where user data is null
        return const LoginScreen();
      }
    }
  }
}
