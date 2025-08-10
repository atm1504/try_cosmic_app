import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'src/app_router.dart';
import 'src/providers/app_state.dart';
import 'src/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const CosmicWellnessApp());
}

class CosmicWellnessApp extends StatelessWidget {
  const CosmicWellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..initialize(),
      child: Builder(
        builder: (context) {
          final router = AppRouter.createRouter(context.read<AppState>());
          return MaterialApp.router(
            title: 'Cosmic Wellness',
            theme: buildAppTheme(Brightness.light),
            darkTheme: buildAppTheme(Brightness.dark),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
