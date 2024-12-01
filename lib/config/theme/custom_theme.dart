import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      dividerTheme: const DividerThemeData(
        color: Color.fromRGBO(0, 0, 0, 0.09),
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D9558),
          primary: const Color(0xFF94ED8C),
          secondary: const Color(0xFFB9B9B9),
        )
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      dividerTheme: const DividerThemeData(color: Colors.white, space: 20),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D9558),
          primary: Colors.white,
          secondary: const Color(0xFF5D9558),
          brightness: Brightness.dark,
        ),
    );
  }
}