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
}
