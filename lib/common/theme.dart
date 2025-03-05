import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const seedColor = Color(0xFFEC407A);
  static final lightColorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      dynamicSchemeVariant: DynamicSchemeVariant.content,
      brightness: Brightness.light);
  static ThemeData get theme {
    ColorScheme colorScheme = lightColorScheme;
    final baseTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          shape: CircleBorder(), backgroundColor: colorScheme.primary),
    );
    return baseTheme.copyWith(
        textTheme: GoogleFonts.lexendTextTheme(baseTheme.textTheme));
  }
}
