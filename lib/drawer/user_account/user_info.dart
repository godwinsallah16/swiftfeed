// user_info.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';

class UserInfo extends StatelessWidget {
  final AnonUserModel? user; // Make user parameter nullable

  const UserInfo({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountEmail: Text(user is AnonUserModel
          ? ''
          : user?.email ?? ''), // Set email to empty string for anonymous users
      accountName: Text(user?.userId ?? ''), // Use user data if available
      currentAccountPicture: const CircleAvatar(
        foregroundImage: AssetImage('assets/images/swift_logo.png'),
      ),
      otherAccountsPictures: const [],
    );
  }
}
