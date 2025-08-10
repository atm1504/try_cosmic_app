import 'package:flutter/material.dart';
import '../theme/brand.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.background(brightness),
      ),
      child: child,
    );
  }
}
