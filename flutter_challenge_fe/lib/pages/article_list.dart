import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_fe/pages/article_detail.dart';
import '../services/bloc/article_bloc.dart';
import '../services/bloc/article_state.dart';

class ArticleListPage extends StatelessWidget {
  final void Function(bool) onThemeChange;
  final bool isDarkMode;

  const ArticleListPage({
    super.key,
    required this.onThemeChange,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              onThemeChange(!isDarkMode);
            },
          ),
        ],
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticlesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticlesLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return ListTile(
                  title: Text(article.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailPage(article: article),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ArticlesError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('No articles found'));
          }
        },
      ),
    );
  }
}
