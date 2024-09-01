import '../../domain/entities/article.dart';
import '../datasources/article_remote_data_source.dart';
import '../models/article_model.dart'; 

class ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  ArticleRepository(this.remoteDataSource);

  Future<List<Article>> fetchArticles() async {
    // Obtener los artículos como ArticleModel
    List<ArticleModel> articleModels = await remoteDataSource.fetchArticles();

    // Convertir ArticleModel a Article
    return articleModels.map((articleModel) => Article(
      id: articleModel.id,
      title: articleModel.title,
      body: articleModel.body,
    )).toList();
  }
}
