import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final p = app.profile;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: p == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ListTile(title: const Text('Name'), subtitle: Text(p.name)),
                ListTile(title: const Text('Tone'), subtitle: Text(p.tone)),
                ListTile(
                    title: const Text('Timezone'), subtitle: Text(p.timezone)),
                ListTile(
                    title: const Text('Goals'),
                    subtitle: Text(p.goals.join(', '))),
              ],
            ),
    );
  }
}
