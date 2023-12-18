import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../authentication/login/account_login/models/account_user.dart';
import '../../authentication/login/anon_login/models/anon_user_model.dart';

class AccountDrawerHeader extends StatefulWidget {
  final EmailUserModel? emailUser;
  final AnonUserModel? anonUser;

  const AccountDrawerHeader({Key? key, this.emailUser, this.anonUser})
      : super(key: key);

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
        await CachedNetworkImageProvider(widget.emailUser!.profileImageURL!)
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
        backgroundImage:
            imageProvider ?? AssetImage('assets/placeholder_image.png'),
        backgroundColor: Colors.transparent,
        child: _selectedImage == null && _profileImageURL.isEmpty
            ? const Icon(Icons.account_circle)
            : null,
      ),
    );
  }

  Future<void> _showImagePreview(ImageProvider<Object>? imageProvider) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageProvider!,
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
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

      // Store the image path in the database
      await _updateProfileImageInDatabase(_selectedImage!.path);
    }
  }

  Future<void> _updateProfileImageInDatabase(String imagePath) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Upload image to Firebase Storage
        await FirebaseStorage.instance
            .ref('profile_images/${user.uid}.jpg')
            .putFile(File(imagePath));

        // Get the download URL of the uploaded image
        String downloadURL = await FirebaseStorage.instance
            .ref('profile_images/${user.uid}.jpg')
            .getDownloadURL();

        setState(() {
          _profileImageURL = downloadURL;
        });

        // Update the profile image URL in the Firestore database
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profileImageURL': _profileImageURL});

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
