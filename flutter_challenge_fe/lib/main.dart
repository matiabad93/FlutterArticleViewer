import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_fe/pages/article_list.dart';
import 'package:flutter_challenge_fe/services/bloc/article_bloc.dart';
import 'injection_container.dart' as di;

void main() {
  di.init(); // Inicializar dependencias
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => di.sl<ArticleBloc>()..add(FetchArticlesEvent()),
        child: const ArticleListPage(),
      ),
    );
  }
}
