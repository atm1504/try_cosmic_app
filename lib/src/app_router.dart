import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'providers/app_state.dart';
import 'screens/home_screen.dart';
import 'screens/plan_screen.dart';
import 'screens/recover_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/community_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/onboarding_screen.dart';

class AppRouter {
  static GoRouter createRouter(AppState appState) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const OnboardingScreen();
          },
          routes: [
            GoRoute(
              path: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: 'plan',
              builder: (context, state) => const PlanScreen(),
            ),
            GoRoute(
              path: 'recover',
              builder: (context, state) => const RecoverScreen(),
            ),
            GoRoute(
              path: 'chat',
              builder: (context, state) => const ChatScreen(),
            ),
            GoRoute(
              path: 'community',
              builder: (context, state) => const CommunityScreen(),
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
      initialLocation: '/',
      debugLogDiagnostics: false,
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}
