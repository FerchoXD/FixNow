import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF4C98E9),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF4C98E9),
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      color: const Color(0xFF555E69),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: const Color(0xFF555E69),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF4C98E9),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      color: const Color(0xFFFFFFFF),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: const Color(0xFFFFFFFF),
    ),
  ),
);
