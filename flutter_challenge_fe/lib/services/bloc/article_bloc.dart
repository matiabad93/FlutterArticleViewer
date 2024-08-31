import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_fe/services/bloc/article_event.dart';
import 'package:flutter_challenge_fe/services/bloc/article_state.dart';
import '../../domain/usecases/get_articles.dart';

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
