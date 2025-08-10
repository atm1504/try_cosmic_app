import 'package:flutter/material.dart';

ThemeData buildAppTheme(Brightness brightness) {
  final Color seed = brightness == Brightness.light
      ? const Color(0xFF3366FF)
      : const Color(0xFF7BA4FF);
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor:
        brightness == Brightness.light ? Colors.grey[50] : Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: scheme.surfaceVariant,
      selectedColor: scheme.primaryContainer,
      labelStyle: TextStyle(color: scheme.onSurface),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    listTileTheme: const ListTileThemeData(contentPadding: EdgeInsets.all(12)),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
  );
}
