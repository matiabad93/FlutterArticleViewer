import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_articles.dart';

abstract class ArticleEvent {}

class FetchArticlesEvent extends ArticleEvent {}

abstract class ArticleState {}

class ArticlesInitial extends ArticleState {}

class ArticlesLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Article> articles;

  ArticlesLoaded(this.articles);
}

class ArticlesError extends ArticleState {
  final String message;

  ArticlesError(this.message);
}

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles getArticles;

  ArticleBloc(this.getArticles) : super(ArticlesInitial()) {
    on<FetchArticlesEvent>((event, emit) async {
      emit(ArticlesLoading());
      try {
        final articles = await getArticles();
        emit(ArticlesLoaded(articles));
      } catch (e) {
        emit(ArticlesError(e.toString()));
      }
    });
  }
}
