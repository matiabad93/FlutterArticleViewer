// services/bloc/article_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_fe/services/bloc/article_event.dart';
import 'package:flutter_challenge_fe/services/bloc/article_state.dart';
import 'package:flutter_challenge_fe/services/database/database_helper.dart';
import 'package:flutter_challenge_fe/data/models/article_model.dart';
import '../../domain/usecases/get_articles.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles getArticles;
  final DatabaseHelper dbHelper;

  ArticleBloc(this.getArticles, this.dbHelper) : super(ArticlesInitial()) {
    on<FetchArticlesEvent>((event, emit) async {
      emit(ArticlesLoading());
      try {
        final cachedArticles = await dbHelper.getArticles();

        // Convertir `ArticleModel` a `Article` antes de emitir el estado
        final domainArticles = cachedArticles.map((e) => e.toArticle()).toList();

        if (domainArticles.isNotEmpty) {
          emit(ArticlesLoaded(domainArticles));
        } else {
          final articles = await getArticles();

          // Convertir `Article` a `ArticleModel` antes de insertarlos en la DB
          final articlesToCache = articles.map((e) => ArticleModel.fromArticle(e)).toList();
          await dbHelper.insertArticles(articlesToCache);
          emit(ArticlesLoaded(articles));
        }
      } catch (e) {
        emit(ArticlesError(e.toString()));
      }
    });
  }
}
