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
        body: SafeArea(
          child: NewsScreen(
            newsList: [
              News(
                title:
                    'Mahama pledges petro-chemical industry and economic boost for Jomoro',
                media: Image.asset('assets/images/mahama.jpg'),
                likeCount: 55,
                commentCount: 8,
              ),
              News(
                title:
                    'Trend analysis indicates that six persons died daily from road crashes, the National Road Safety Authority (NRSA) has stated',
                media: Image.asset('assets/images/crash.png'),
                likeCount: 78,
                commentCount: 57,
              ),
              News(
                title: 'The Gods Are Not to Blame’ returns on popular demand',
                media: Image.asset('assets/images/gods.png'),
                likeCount: 235,
                commentCount: 47,
              ),
              News(
                title:
                    'Ministry proposes 544% increase in passport application fees',
                media: Image.asset('assets/images/passoffice.jpg'),
                likeCount: 45,
                commentCount: 23,
              ),
            ],
          ),
          // Add your NewsScreen or any other content here
        ),
      ),
    );
  }
}
