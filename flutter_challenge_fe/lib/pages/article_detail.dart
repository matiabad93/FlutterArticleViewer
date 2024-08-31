import 'package:flutter/material.dart';
import '../domain/entities/article.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineMedium, 
            ),
            const SizedBox(height: 16.0),
            Text(
              article.body,
              style: Theme.of(context).textTheme.bodyMedium, 
            ),
          ],
        ),
      ),
    );
  }
}
