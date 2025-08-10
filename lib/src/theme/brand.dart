import 'package:flutter/material.dart';

class BrandColors {
  static const Color violet = Color(0xFF7C3AED); // violet-600
  static const Color fuchsia = Color(0xFFD946EF); // fuchsia-500
  static const Color cyan = Color(0xFF06B6D4); // cyan-500
  static const Color indigo = Color(0xFF6366F1); // indigo-500
  static const Color blue = Color(0xFF3B82F6); // blue-500
  static const Color purple = Color(0xFF8B5CF6); // purple-500
}

class AppGradients {
  static LinearGradient background(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF0B1020),
          BrandColors.violet.withOpacity(0.35),
          BrandColors.indigo.withOpacity(0.3),
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFF5F7FF),
          BrandColors.purple.withOpacity(0.22),
          BrandColors.cyan.withOpacity(0.22),
        ],
      );
    }
  }

  static LinearGradient hero(BuildContext context) {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        BrandColors.violet,
        BrandColors.fuchsia,
        BrandColors.cyan,
      ],
    );
  }

  static LinearGradient accent(BuildContext context) {
    return const LinearGradient(
      colors: [BrandColors.violet, BrandColors.cyan],
    );
  }
}
