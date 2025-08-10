import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/gradient_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final today = app.today;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today', style: Theme.of(context).textTheme.titleLarge),
            Text(
              DateTime.now().toLocal().toString().split(' ').first,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.go('/profile'),
            icon: const Icon(Icons.person_outline),
            tooltip: 'Profile',
          )
        ],
      ),
      bottomNavigationBar: const BottomNav(current: 0),
      body: SafeArea(
        child: GradientBackground(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: _HeroHeader(snapshotExists: today != null)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      if (today != null) _TodayAtAGlance(),
                      const _OneTapRelief(),
                      const _DailyHabit(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayAtAGlance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final snapshot = app.today!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                ),
                const SizedBox(width: 8),
                Text('Color: ${snapshot.color}')
              ],
            ),
            const SizedBox(height: 8),
            Text('Focus: ${snapshot.focus}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text('Recommended windows',
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            ...snapshot.windows.take(3).map((w) => ListTile(
                  leading: CircleAvatar(
                    radius: 12,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(Icons.check,
                        size: 16,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  title: Text(
                      '${_fmt(context, w.start)} – ${_fmt(context, w.end)}'),
                  subtitle: Text(w.why.join(' • ')),
                )),
            if (snapshot.windows.length > 2)
              ListTile(
                leading: const Icon(Icons.block, color: Colors.redAccent),
                title: Text(
                    '${_fmt(context, snapshot.windows.last.start)} – ${_fmt(context, snapshot.windows.last.end)}'),
                subtitle: const Text('Avoid window'),
              ),
          ],
        ),
      ),
    );
  }

  String _fmt(BuildContext context, DateTime d) =>
      TimeOfDay.fromDateTime(d).format(context);
}

class _OneTapRelief extends StatefulWidget {
  const _OneTapRelief();

  @override
  State<_OneTapRelief> createState() => _OneTapReliefState();
}

class _OneTapReliefState extends State<_OneTapRelief> {
  String feeling = 'I feel…';
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('One‑tap Relief',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Panic'),
                  selected: feeling == 'Panic',
                  onSelected: (_) => setState(() => feeling = 'Panic'),
                ),
                ChoiceChip(
                  label: const Text('Grounding'),
                  selected: feeling == 'Grounding',
                  onSelected: (_) => setState(() => feeling = 'Grounding'),
                ),
                ChoiceChip(
                  label: const Text('Sleep reset'),
                  selected: feeling == 'Sleep reset',
                  onSelected: (_) => setState(() => feeling = 'Sleep reset'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => _showBreath(context),
              child: const Text('Start 90‑sec relief'),
            ),
          ],
        ),
      ),
    );
  }

  void _showBreath(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (c) => SizedBox(
        height: 320,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Relief (90 sec)',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              const Text(
                  'Let’s bring you down from 8/10 to 5/10. Inhale 4… exhale 6… twice more.'),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check),
                label: const Text('I feel better'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyHabit extends StatelessWidget {
  const _DailyHabit();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Habit', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Box breathing 4‑4‑4‑4. 2–5 minutes.'),
            const SizedBox(height: 12),
            Row(
              children: [
                FilledButton(onPressed: () {}, child: const Text('Do now')),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => context.go('/plan'),
                  child: const Text('Schedule at right time'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.snapshotExists});
  final bool snapshotExists;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7C3AED), // violet
            Color(0xFFD946EF), // fuchsia
            Color(0xFF06B6D4), // cyan
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(0.35),
            blurRadius: 24,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome, color: scheme.onPrimaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshotExists ? 'Right-time insights' : 'Welcome',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  snapshotExists
                      ? 'Your windows and daily focus are ready.'
                      : 'Let’s get you a calmer, clearer day.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: scheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// no global navigator key needed here


