import 'package:flutter/material.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';
import 'package:swiftfeed/drawer/screens/drawer_header.dart';

class DrawerContentForm extends StatelessWidget {
  final EmailUserModel? emailUser;
  final AnonUserModel? anonUser;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerContentForm(
      {Key? key, this.emailUser, this.anonUser, required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200, // Set a fixed height for the header
            child: AccountDrawerHeader(
              emailUser: emailUser,
              anonUser: anonUser,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Sports'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Entertainment'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Business'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Politics'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Foreign'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                // Add more list items for other news sections if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
