import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftfeed/authentication/login/account_login/models/account_user.dart';
import 'package:swiftfeed/authentication/login/anon_login/models/anon_user_model.dart';

import '../services/profile_update.dart';

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
  late String _profileImageURL = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _shouldClearCache = false;
  bool _isUpdatingImage = false;
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();

    // Schedule the _initializeProfileImage method after the initState is completed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProfileImage();
    });
  }

  Future<void> _initializeProfileImage() async {
    if (widget.emailUser != null && widget.emailUser!.profileImageURL != null) {
      // Check if the profile image is already in cache
      if (!ImageCache().containsKey(widget.emailUser!.profileImageURL!)) {
        print('Profile image is not in cache, downloading and precaching...');
        // If not in cache, download and precache the image
        CachedNetworkImageProvider(widget.emailUser!.profileImageURL!)
            .resolve(const ImageConfiguration());
      }

      // Set the profile image URL
      setState(() {
        _profileImageURL = widget.emailUser!.profileImageURL!;
      });

      if (_shouldClearCache) {
        // Clear the image cache if a new update is made
        imageCache.clear();
        imageCache.clearLiveImages();
        _shouldClearCache = false; // Reset the flag
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Builder(
        builder: (context) {
          _isDrawerOpen = Scaffold.of(context).isDrawerOpen;

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                height: 210, // Increase the height by 40px
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          if (_isDrawerOpen) {
                            _pickImage(context);
                          }
                        },
                        onTap: () {
                          if (_isDrawerOpen) {
                            _showImagePreview(_buildAccountImage());
                          }
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              key: ValueKey<String>(_profileImageURL),
                              radius: 60,
                              backgroundImage: _buildAccountImage(),
                              backgroundColor: Colors.transparent,
                            ),
                            if (_isUpdatingImage)
                              const Positioned.fill(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildAccountName(),
                      _buildAccountEmail(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAccountName() {
    return Text('Username: ${widget.emailUser?.username ?? 'Guest'}');
  }

  Widget _buildAccountEmail() {
    return Text('Email: ${widget.emailUser?.email ?? ''}');
  }

  ImageProvider<Object> _buildAccountImage() {
    if (_selectedImage != null) {
      // If a new image is selected, use it
      return FileImage(_selectedImage!);
    } else if (_profileImageURL.isNotEmpty) {
      // If profile image URL is available, use it
      return CachedNetworkImageProvider(_profileImageURL);
    } else {
      // Use asset image if no profile picture
      return const AssetImage('assets/icons/account-icon.jpg');
    }
  }

  Future<void> _showImagePreview(ImageProvider<Object> imageProvider) async {
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
                    image: imageProvider,
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

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _isUpdatingImage = true; // Set the flag to true when update starts
      });

      try {
        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          await ProfileUpdateService.updateProfileImage(
            context,
            currentUser,
            _selectedImage!,
          );

          currentUser = await FirebaseAuth.instance.currentUser;

          setState(() {
            _profileImageURL =
                currentUser?.photoURL ?? ''; // Update with the new photoURL
            _isUpdatingImage =
                false; // Set the flag to false when update is complete
          });

          // Trigger a rebuild of the drawer
          _scaffoldKey.currentState?.openEndDrawer();
          _scaffoldKey.currentState?.openDrawer();

          print('Profile image updated successfully!');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile image updated successfully!'),
            ),
          );
        }
      } catch (e) {
        print('Error updating profile image: $e');
        setState(() {
          _isUpdatingImage = false;
        });
      }
    }
  }
}
