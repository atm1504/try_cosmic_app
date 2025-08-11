import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/providers.dart';
import '../widgets/astro_cards.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blueprintAsync = ref.watch(dailyBlueprintProvider);
    return SafeArea(
      child: blueprintAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Failed to load: $e')),
        data: (data) {
          final locationLabel = 'Auto location';
          final greeting = DateFormat('EEE, MMM d').format(data.date);
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Text('Today · $greeting'),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  HeaderCard(
                      data: data,
                      userName: 'Aarav',
                      locationLabel: locationLabel),
                  AstroTimingCard(data: data),
                  HabitCard(
                    data: data,
                    onDoNow: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        builder: (_) =>
                            _QuickPracticeSheet(habitType: data.habit.type),
                      );
                    },
                  ),
                  ReliefCard(
                    title: 'One-tap relief',
                    subtitle:
                        '90–180 sec practice aligned with today\'s energy',
                    icon: Icons.self_improvement,
                    onStart: () => showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (_) => const _ReliefPicker(),
                    ),
                  ),
                  const _MoodJournalCard(),
                  const SizedBox(height: 24),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _QuickPracticeSheet extends StatelessWidget {
  final String habitType;
  const _QuickPracticeSheet({required this.habitType});

  @override
  Widget build(BuildContext context) {
    final title = switch (habitType) {
      'journal' => '2-minute journaling',
      'movement' => '2-minute stretch',
      'social' => 'Connect with care',
      _ => 'Quick practice',
    };
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(
              'Follow a short guided prompt aligned with today\'s planetary support.'),
          const SizedBox(height: 16),
          FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Start')),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ReliefPicker extends StatelessWidget {
  const _ReliefPicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            title: const Text('Guided breathing'),
            subtitle: const Text('Moon strong in water signs'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.wb_sunny_outlined),
            title: const Text('Affirmations'),
            subtitle: const Text('Sun favorable'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.terrain_outlined),
            title: const Text('Grounding exercise'),
            subtitle: const Text('Saturn heavy'),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _MoodJournalCard extends StatefulWidget {
  const _MoodJournalCard();

  @override
  State<_MoodJournalCard> createState() => _MoodJournalCardState();
}

class _MoodJournalCardState extends State<_MoodJournalCard> {
  double mood = 5;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick mood & journal',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.mood_outlined),
                Expanded(
                  child: Slider(
                    value: mood,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: mood.round().toString(),
                    onChanged: (v) => setState(() => mood = v),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'One-line note'),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Builder(builder: (context) {
                return FilledButton(
                  onPressed: () {
                    // This is a demo save; storage wires exist via provider if desired.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved to trends')),
                    );
                    _controller.clear();
                  },
                  child: const Text('Save'),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
