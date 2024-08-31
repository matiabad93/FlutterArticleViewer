import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/article_model.dart';

class ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSource(this.client);

  Future<List<ArticleModel>> fetchArticles() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((article) => ArticleModel.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
