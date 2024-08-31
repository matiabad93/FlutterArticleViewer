import '../../domain/entities/article.dart';
import '../datasources/article_remote_data_source.dart';

class ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  ArticleRepository(this.remoteDataSource);

  Future<List<Article>> fetchArticles() async {
    return await remoteDataSource.fetchArticles();
  }
}
