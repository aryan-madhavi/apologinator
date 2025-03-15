import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Nunito',
  brightness: Brightness.dark,
  primaryColor: Color(0xFF141414), // Onyx Black
  scaffoldBackgroundColor: Color(0xFF0A0A0A), // Pure Black
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFEAEAEA), fontWeight: FontWeight.bold), // Soft Platinum
    bodyMedium: TextStyle(color: Color(0xFFB8B8B8), fontWeight: FontWeight.bold), // Muted Silver (Secondary)
    titleLarge: TextStyle(color: Color(0xFFEAEAEA), fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Color(0xFFEAEAEA), fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: Color(0xFFB8B8B8), fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF141414), // Onyx Black
    secondary: Color(0xFFCBA135), // Rich Gold (Accent)
    surface: Color(0xFF1C1C1C), // Deep Charcoal
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onBackground: Color(0xFFEAEAEA), // Soft Platinum
    onSurface: Color(0xFFEAEAEA),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xFFEAEAEA), // Ensuring visible cursor
    selectionColor: Color(0xFF505050), // Selection highlight color
    selectionHandleColor: Color(0xFFCBA135), // Handle color
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xFFEAEAEA), // Soft Platinum
    ),
    floatingLabelStyle: TextStyle(
      color: Color(0xFFEAEAEA), // Soft Platinum
    ),
    hintStyle: TextStyle(
      color: Color(0xFF8A8A8A), // Medium Gray for better contrast
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFB8B8B8)), // Muted Silver
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFB8B8B8)), // Visible border in dark mode
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFB8B8B8)), // Highlight in Rich Gold
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFA7894B), // Dark Gold
      foregroundColor: Colors.white, // Button text
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6, // Soft shadow for 
      textStyle: TextStyle(fontWeight: FontWeight.w500)
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFCBA135), // Rich Gold
      side: BorderSide(color: Color(0xFFCBA135)), // Rich Gold border
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFCBA135), // Rich Gold for visibility
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1C1C1C), // Deep Charcoal for a refined look
    foregroundColor: Color(0xFFEAEAEA), // Soft Platinum for contrast
    elevation: 3,
  ),
);
