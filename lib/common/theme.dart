import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const seedColor = Color(0xFFEC407A);
  static final lightColorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      dynamicSchemeVariant: DynamicSchemeVariant.content,
      brightness: Brightness.light);
  static final darkColorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      dynamicSchemeVariant: DynamicSchemeVariant.content,
      brightness: Brightness.dark);
  static ThemeData getTheme(Brightness brightness) {
    ColorScheme colorScheme =
        brightness == Brightness.light ? lightColorScheme : darkColorScheme;
    return ThemeData().copyWith(
      colorScheme: colorScheme,
      textTheme: GoogleFonts.lexendTextTheme(),
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          shape: CircleBorder(), backgroundColor: colorScheme.primary),
    );
  }
}
