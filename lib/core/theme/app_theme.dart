import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = commonTheme;
}

final commonTheme = ThemeData(
  useMaterial3: false,
  appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink)),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12)),
  ),
);
