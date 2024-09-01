import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({required int id, required String title, required String body})
      : super(id: id, title: title, body: body);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  Article toArticle() {
    return Article(id: id, title: title, body: body);
  }

  factory ArticleModel.fromArticle(Article article) {
    return ArticleModel(
      id: article.id,
      title: article.title,
      body: article.body,
    );
  }
}
