import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/gradient_background.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final p = app.profile;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF7C3AED),
                  Color(0xFFD946EF),
                  Color(0xFF06B6D4),
                ],
              ).createShader(rect),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text('Profile'),
          ],
        ),
      ),
      body: GradientBackground(
        child: p == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ListTile(title: const Text('Name'), subtitle: Text(p.name)),
                  ListTile(title: const Text('Tone'), subtitle: Text(p.tone)),
                  ListTile(
                      title: const Text('Timezone'),
                      subtitle: Text(p.timezone)),
                  ListTile(
                      title: const Text('Goals'),
                      subtitle: Text(p.goals.join(', '))),
                ],
              ),
      ),
    );
  }
}
