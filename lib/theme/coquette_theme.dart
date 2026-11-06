import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoquetteColors {
  static const Color babyPink = Color(0xFFFADADD);
  static const Color blushPink = Color(0xFFF7C6CE);
  static const Color softPink = Color(0xFFF8D7DE);
  static const Color cream = Color(0xFFFFF8E8);
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color dustyRose = Color(0xFFD4A5A5);
  static const Color roseGold = Color(0xFFE8B4B8);
  static const Color deepRose = Color(0xFFA9536C);
  static const Color textDark = Color(0xFF5C4A4A);
  static const Color textLight = Color(0xFF8B6F6F);
}

class CoquetteTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: CoquetteColors.cream,
      primaryColor: CoquetteColors.blushPink,
      colorScheme: ColorScheme.light(
        primary: CoquetteColors.blushPink,
        secondary: CoquetteColors.roseGold,
        surface: CoquetteColors.ivory,
        background: CoquetteColors.cream,
        onPrimary: CoquetteColors.textDark,
        onSurface: CoquetteColors.textDark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: CoquetteColors.babyPink,
        foregroundColor: CoquetteColors.textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.pinyonScript(
          fontSize: 28,
          color: CoquetteColors.deepRose,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.pinyonScript(
          fontSize: 42,
          color: CoquetteColors.deepRose,
        ),
        displayMedium: GoogleFonts.pinyonScript(
          fontSize: 32,
          color: CoquetteColors.deepRose,
        ),
        titleLarge: GoogleFonts.quicksand(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: CoquetteColors.textDark,
        ),
        bodyLarge: GoogleFonts.quicksand(
          fontSize: 16,
          color: CoquetteColors.textDark,
        ),
        bodyMedium: GoogleFonts.quicksand(
          fontSize: 14,
          color: CoquetteColors.textLight,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: CoquetteColors.blushPink,
        foregroundColor: CoquetteColors.deepRose,
      ),
      cardTheme: CardTheme(
        color: CoquetteColors.ivory,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: CoquetteColors.softPink, width: 1.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CoquetteColors.ivory,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CoquetteColors.softPink),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CoquetteColors.blushPink, width: 2),
        ),
      ),
    );
  }
}
