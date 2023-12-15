// home.dart
import 'package:flutter/material.dart';
import 'package:swiftfeed/drawer_content.dart';
import 'package:swiftfeed/news/news_template/home_template.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 1;
  bool isSelectedHome = false;
  bool isSelectedAdd = false;
  bool isSelectedBookmark = false;
  bool isSelectedSettings = false;

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
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const DrawerContent(),
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
