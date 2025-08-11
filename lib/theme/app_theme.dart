import 'package:flutter/material.dart';

ThemeData buildCosmicTheme(TextTheme baseTextTheme) {
  const seed = Color(0xFF6C6CF4); // cosmic indigo
  final colorScheme =
      ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);

  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    textTheme: baseTextTheme.apply(
      displayColor: colorScheme.onSurface,
      bodyColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    cardTheme: CardTheme(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
    ),
    chipTheme: ChipThemeData(
      side: BorderSide(color: colorScheme.outlineVariant),
      selectedColor: colorScheme.primaryContainer,
      labelStyle: baseTextTheme.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
