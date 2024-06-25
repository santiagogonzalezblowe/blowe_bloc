import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
}

final _lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    error: Colors.red,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 12,
    ),
  ),
);

final _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.purple,
  colorScheme: const ColorScheme.dark(
    primary: Colors.purple,
    error: Colors.red,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 12,
    ),
  ),
);
