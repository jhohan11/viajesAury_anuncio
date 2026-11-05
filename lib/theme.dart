import 'package:flutter/material.dart';

const ocean = Color(0xFF009D9C);
const deepOcean = Color(0xFF007B88);
const coral = Color(0xFFFF655C);
const ink = Color(0xFF13243A);
const pale = Color(0xFFF2F8FB);

ThemeData buildTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: ocean,
    primary: ocean,
    secondary: coral,
    surface: Colors.white,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: base,
    scaffoldBackgroundColor: pale,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: ink,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    ),
  );
}
