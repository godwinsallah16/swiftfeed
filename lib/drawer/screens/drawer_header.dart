import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';

import '../services/profile_update.dart';

class AccountDrawerHeader extends StatefulWidget {
  final EmailUserModel? emailUser;
  final AnonUserModel? anonUser;

  const AccountDrawerHeader({super.key, this.emailUser, this.anonUser});

  @override
  _AccountDrawerHeaderState createState() => _AccountDrawerHeaderState();
}

class _AccountDrawerHeaderState extends State<AccountDrawerHeader> {
  File? _selectedImage;
  String _profileImageURL = '';

  @override
  void initState() {
    super.initState();
    _initializeProfileImage();
  }

  Future<void> _initializeProfileImage() async {
    if (widget.emailUser != null && widget.emailUser!.profileImageURL != null) {
      // Check if the profile image is already in cache
      if (!ImageCache().containsKey(widget.emailUser!.profileImageURL!)) {
        // If not in cache, download and precache the image
        CachedNetworkImageProvider(widget.emailUser!.profileImageURL!)
            .resolve(const ImageConfiguration());
      }

      // Set the profile image URL
      setState(() {
        _profileImageURL = widget.emailUser!.profileImageURL!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      accountName: _buildAccountName(),
      accountEmail: _buildAccountEmail(),
      currentAccountPicture: _buildAccountImage(),
      otherAccountsPictures: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _pickImage(),
        ),
      ],
    );
  }

  Widget _buildAccountName() {
    return Text('Username: ${widget.emailUser?.username ?? 'Guest'}');
  }

  Widget _buildAccountEmail() {
    return Text('Email: ${widget.emailUser?.email ?? ''}');
  }

  Widget _buildAccountImage() {
    ImageProvider<Object>? imageProvider;

    if (_selectedImage != null) {
      // If a new image is selected, use it
      imageProvider = FileImage(_selectedImage!);
    } else if (_profileImageURL.isNotEmpty) {
      // If profile image URL is available, use it
      imageProvider = CachedNetworkImageProvider(_profileImageURL);
    }

    return GestureDetector(
      onTap: () => _showImagePreview(imageProvider),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: imageProvider ??
            const AssetImage(
                'assets/icons/account-icon.jpg'), // Use asset image if no profile picture
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Future<void> _showImagePreview(ImageProvider<Object>? imageProvider) async {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Dismissible(
          key: const Key('dismissibleKey'),
          onDismissed: (direction) {
            Navigator.of(context).pop();
          },
          background: Container(color: Colors.transparent),
          child: Center(
            child: GestureDetector(
              onVerticalDragDown: (_) {},
              onVerticalDragUpdate: (details) {
                double delta = details.primaryDelta!;
                double newHeight = screenHeight * 0.6 + delta;
                if (newHeight > 0 && newHeight < screenHeight) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.6,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: imageProvider ??
                        const AssetImage('assets/icons/account-icon.jpg'),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      try {
        // Use the ProfileUpdateService to update the profile image
        await ProfileUpdateService.updateProfileImage(_selectedImage!);

        // Show a snackbar only if the drawer is open
        if (Scaffold.of(context).isDrawerOpen) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile image updated successfully!'),
            ),
          );
        }
      } catch (e) {
        print('Error updating profile image: $e');
      }
    }
  }
}
