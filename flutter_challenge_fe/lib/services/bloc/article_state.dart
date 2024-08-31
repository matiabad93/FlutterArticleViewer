import 'package:flutter_challenge_fe/domain/entities/article.dart';

abstract class ArticleState {}

class ArticlesInitial extends ArticleState {}

class ArticlesLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Article> articles;

  ArticlesLoaded(this.articles);
}

class ArticlesError extends ArticleState {
  final String error;

  ArticlesError(this.error);
}
