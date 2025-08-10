import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'brand.dart';

ThemeData buildAppTheme(Brightness brightness) {
  final Color seed =
      brightness == Brightness.light ? BrandColors.violet : BrandColors.indigo;
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Avoid runtime network fetch if blocked; fall back to default if it fails.
    textTheme: GoogleFonts.interTextTheme(),
    scaffoldBackgroundColor: brightness == Brightness.light
        ? const Color(0xFFF8F9FF)
        : const Color(0xFF0A0D16),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: scheme.surfaceVariant,
      selectedColor: scheme.primaryContainer,
      labelStyle: TextStyle(color: scheme.onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    listTileTheme: const ListTileThemeData(contentPadding: EdgeInsets.all(12)),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: brightness == Brightness.light
          ? scheme.surfaceVariant.withOpacity(0.3)
          : scheme.surfaceVariant.withOpacity(0.2),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surface,
      indicatorColor: scheme.primaryContainer,
      elevation: 0,
      height: 68,
      surfaceTintColor: Colors.transparent,
      iconTheme: MaterialStateProperty.resolveWith((states) {
        final bool selected = states.contains(MaterialState.selected);
        return IconThemeData(
          color: selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
        );
      }),
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        final bool selected = states.contains(MaterialState.selected);
        return TextStyle(
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          color: selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
        );
      }),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant,
      space: 24,
      thickness: 1,
    ),
  );
}
