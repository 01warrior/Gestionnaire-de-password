import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF203656);
  static const Color secondaryColor = Color(0xFFFFFF00);

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      selectedItemColor:  AppTheme.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.primaryColor,
      ),
    ),
    textTheme: GoogleFonts.robotoSlabTextTheme(),
  );
}