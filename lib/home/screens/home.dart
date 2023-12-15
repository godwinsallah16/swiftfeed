// home.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/news/news_template/home_template.dart';

class Home extends StatefulWidget {
  final dynamic user; // Change the type to dynamic

  const Home({super.key, this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[800],
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Open the drawer when the menu icon is tapped
                Scaffold.of(context).openDrawer();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: NewsScreen(
            newsList: [
              News(
                title: 'Sample News',
                media: Image.asset('assets/images/swift_logo.png'),
                likeCount: 15,
                commentCount: 7,
              ),
              News(
                title: 'Sample News',
                media: Image.asset('assets/images/swift_logo.png'),
                likeCount: 15,
                commentCount: 7,
              ),
              News(
                title: 'Sample News',
                media: Image.asset('assets/images/swift_logo.png'),
                likeCount: 15,
                commentCount: 7,
              ),
              News(
                title: 'Sample News',
                media: Image.asset('assets/images/swift_logo.png'),
                likeCount: 15,
                commentCount: 7,
              ),
            ],
          ),
          // Add your NewsScreen or any other content here
        ),
      ),
    );
  }
}
