import '../entities/article.dart';
import '../../data/repositories/article_repository.dart';

class GetArticles {
  final ArticleRepository repository;

  GetArticles(this.repository);

  Future<List<Article>> call() async {
    return await repository.fetchArticles();
  }
}