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
          primary: const Color(0xFF5D9558),
          secondary: const Color(0xFF6B6B6B),
          shadow: Colors.black,
          scrim: Colors.white,
        )
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      dividerTheme: const DividerThemeData(color: Colors.white, space: 20),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D9558),
          primary: const Color(0xFF5D9558),
          secondary: Colors.white,
          brightness: Brightness.dark,
          shadow: Colors.white,
          scrim: Colors.black,
        ),
    );
  }
}