import 'package:flutter/material.dart';

// Definición de colores personalizados para tu aplicación
class AppColors {
  // Color primario (amber)
  static const Color primaryColor = Colors.amber;

  // Color secundario (gris claro y oscuro)
  static const Color secondaryColorLight = Colors.grey;
  static const Color secondaryColorDark = Colors.grey;

  // Fondo oscuro (gris oscuro)
  static const Color backgroundColor = Color(0xFF212121); // Similar a Colors.grey[900]

  // Colores de texto
  static const Color textColor = Colors.white;
  static const Color subtitleColor = Colors.grey;
  static const Color highlightedTextColor = Colors.black;

  // Color para texto de los botones
  static const Color buttonTextColor = Colors.black; // Color negro para el texto del botón
}

// Tema de la aplicación
class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.textColor),
        bodyMedium: TextStyle(color: AppColors.subtitleColor),
        headlineLarge: TextStyle(color: AppColors.highlightedTextColor),
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: AppColors.highlightedTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.buttonTextColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
