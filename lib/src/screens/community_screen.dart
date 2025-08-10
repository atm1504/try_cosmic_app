import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/gradient_background.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool optedIn = false;
  final List<String> posts = [];

  @override
  Widget build(BuildContext context) {
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
              child: const Icon(Icons.groups, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text('Community'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(current: 4),
      body: SafeArea(
        child: GradientBackground(
          child: optedIn ? _feed(context) : _gate(context),
        ),
      ),
      floatingActionButton: optedIn
          ? FloatingActionButton.extended(
              onPressed: () =>
                  setState(() => posts.add("I did today’s routine")),
              icon: const Icon(Icons.check),
              label: const Text("I did today’s routine"),
            )
          : null,
    );
  }

  Widget _gate(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Opt in to a gentle, private community'),
            const SizedBox(height: 12),
            FilledButton(
                onPressed: () => setState(() => optedIn = true),
                child: const Text('Join')),
          ],
        ),
      ),
    );
  }

  Widget _feed(BuildContext context) {
    final prompts = ['Small wins', 'Hard day?'];
    return ListView(
      children: [
        Wrap(
          spacing: 8,
          children: prompts
              .map((p) => ActionChip(
                    label: Text(p),
                    onPressed: () => setState(() => posts.add(p)),
                  ))
              .toList(),
        ),
        const Divider(),
        ...posts.reversed.map((p) => ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(p),
              trailing: const Icon(Icons.thumb_up_alt_outlined),
            )),
      ],
    );
  }
}
