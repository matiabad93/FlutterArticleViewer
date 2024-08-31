import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'pages/article_list.dart';
import 'services/bloc/article_bloc.dart';
import 'services/bloc/article_event.dart';

void main() {
  di.init(); 
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ArticleBloc>()..add(FetchArticlesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App',
        theme: _isDarkMode ? _darkTheme : _lightTheme,
        darkTheme: _darkTheme,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: ArticleListPage(
          onThemeChange: _toggleDarkMode,
          isDarkMode: _isDarkMode,
        ),
      ),
    );
  }

  ThemeData get _lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }

  ThemeData get _darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
