import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/news_page_model.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffFBF4F4),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xff254a83),
                  Color(0xffffffff),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("News Details"),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff254a83),
                    Color(0xffffffff),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.centerRight,
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 16, bottom: 16),
              child: Column(
                children: [
                  Text(
                    article.description ?? 'No description available.',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  article.urlToImage != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(article.urlToImage!),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      article.content != null && article.content!.isNotEmpty
                          ? article.content!
                          : 'No content available.',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8, left: 8, top: 16),
            child: Row(
              children: [
                Text('Read more at'),
                SizedBox(width: 8),
                Icon(Icons.link, color: Colors.blue)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                if (article.url != null) {
                  launchUrl(Uri.parse(article.url!));
                }
              },
              child: Text(
                '${article.url}',
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
