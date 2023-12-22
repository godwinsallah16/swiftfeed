import 'package:flutter/material.dart';

class ProfileImageState extends ChangeNotifier {
  String _profileImageURL = '';

  String get profileImageURL => _profileImageURL;

  void updateProfileImageURL(String newURL) {
    _profileImageURL = newURL;
    notifyListeners();
  }
}
