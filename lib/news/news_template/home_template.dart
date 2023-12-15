import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  final List<News> newsList;

  const NewsScreen({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: NewsItem(news: newsList[index]),
          );
        },
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[600],
            child: FittedBox(
              fit: BoxFit.fill,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: news.media,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle like button press
                      },
                      icon: const Icon(Icons.thumb_up),
                    ),
                    Text(
                      news.likeCount != null ? '${news.likeCount}' : '0',
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle dislike button press
                      },
                      icon: const Icon(Icons.thumb_down),
                    ),
                    Text(
                      news.dislikeCount != null ? '${news.dislikeCount}' : '0',
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        // Handle comment button press
                      },
                    ),
                    Text(
                      news.commentCount != null ? '${news.commentCount}' : '0',
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Handle share button press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class News {
  final String title;
  final Widget media;
  final int? likeCount;
  final int? dislikeCount;
  final int? commentCount;

  News({
    required this.title,
    required this.media,
    this.likeCount,
    this.dislikeCount,
    this.commentCount,
  });
}
