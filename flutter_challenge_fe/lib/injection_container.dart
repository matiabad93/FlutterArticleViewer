import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/article_remote_data_source.dart';
import 'data/repositories/article_repository.dart';
import 'domain/usecases/get_articles.dart';
import 'services/bloc/article_bloc.dart';
import 'services/database/database_helper.dart';

final sl = GetIt.instance;

void init() {
  // BloC
  sl.registerFactory(() => ArticleBloc(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetArticles(sl()));

  // Repositories
  sl.registerLazySingleton<ArticleRepository>(
      () => ArticleRepository(sl()));

  // Data sources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSource(sl()));

  // Database helper
  sl.registerLazySingleton(() => DatabaseHelper());

  // External
  sl.registerLazySingleton(() => http.Client());
}
