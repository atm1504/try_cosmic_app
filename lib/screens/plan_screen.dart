import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/plan_models.dart';
import '../providers/providers.dart';

class PlanScreen extends ConsumerStatefulWidget {
  const PlanScreen({super.key});

  @override
  ConsumerState<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends ConsumerState<PlanScreen> {
  ActivityKind selected = ActivityKind.conversation;

  @override
  Widget build(BuildContext context) {
    final slotsAsync = ref.watch(rightTimeSlotsProvider(selected));
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Text('Plan', style: Theme.of(context).textTheme.headlineSmall),
          ),
          _ActivitySelector(
            selected: selected,
            onChanged: (v) => setState(() => selected = v),
          ),
          Expanded(
            child: slotsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Failed to load: $e')),
              data: (slots) => ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Right-Time Finder',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  const SizedBox(height: 8),
                  for (final s in slots) _RightTimeTile(slot: s),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivitySelector extends StatelessWidget {
  final ActivityKind selected;
  final ValueChanged<ActivityKind> onChanged;
  const _ActivitySelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = ActivityKind.values;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (final kind in items)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                selected: selected == kind,
                label: Text(kind.label),
                onSelected: (_) => onChanged(kind),
              ),
            ),
        ],
      ),
    );
  }
}

class _RightTimeTile extends ConsumerWidget {
  final RightTimeSlot slot;
  const _RightTimeTile({required this.slot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final start = DateFormat('EEE h:mm a').format(slot.start);
    final end = DateFormat('h:mm a').format(slot.end);
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(slot.score.toString())),
        title: Text('$start – $end'),
        subtitle: Text(slot.reasons.join(' · ')),
        trailing: FilledButton.tonal(
          onPressed: () async {
            final calendar = ref.read(calendarServiceProvider);
            await calendar.addEventToCalendar(
              title: '${slot.activityType} — Cosmic Wellness',
              start: slot.start,
              end: slot.end,
              description: slot.reasons.join(', '),
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to calendar')),
              );
            }
          },
          child: const Text('Add'),
        ),
      ),
    );
  }
}
