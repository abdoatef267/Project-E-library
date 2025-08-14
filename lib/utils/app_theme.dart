import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color accentColor = Color(0xFFFF6584);
  static const Color backgroundColorLight = Color(0xFFF4F5F7);
  static const Color backgroundColorDark = Color(0xFF1E1E1E);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 2,
      titleTextStyle:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      floatingLabelStyle: const TextStyle(color: primaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      titleMedium: TextStyle(color: Colors.black54),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 2,
      titleTextStyle:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      floatingLabelStyle: const TextStyle(color: accentColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
      titleMedium: TextStyle(color: Colors.white54),
    ),
  );
}
