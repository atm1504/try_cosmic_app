import 'package:flutter/material.dart';

import '../models/daily_blueprint.dart';

class HeaderCard extends StatelessWidget {
  final DailyBlueprint data;
  final String userName;
  final String locationLabel;
  const HeaderCard(
      {super.key,
      required this.data,
      required this.userName,
      required this.locationLabel});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: cs.primary),
                const SizedBox(width: 8),
                Text(
                  '${data.date.toLocal().toString().split(' ').first} · $locationLabel',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const Spacer(),
                Chip(label: Text(data.moonPhase)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Moon in ${data.zodiac} — ${data.focus.toLowerCase()} today, $userName.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class AstroTimingCard extends StatelessWidget {
  final DailyBlueprint data;
  const AstroTimingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: _parseColor(data.color.value, cs),
                ),
                const SizedBox(width: 8),
                Text(
                    'Color of the day: ${data.color.value.capitalize()} — ${data.color.planet}')
              ],
            ),
            const SizedBox(height: 12),
            Text('Top auspicious times',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final w in data.windows)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.bolt_outlined),
                title: Text('${w.start} – ${w.end}'),
                subtitle: Text(w.reason.join(', ')),
              ),
            const Divider(height: 24),
            Text('Avoid', style: Theme.of(context).textTheme.titleMedium),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.block_outlined),
              title: Text('${data.avoid.start} – ${data.avoid.end}'),
              subtitle: Text(data.avoid.reason.join(', ')),
            ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String value, ColorScheme cs) {
    switch (value.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'gold':
        return const Color(0xFFFFD166);
      default:
        return cs.primary;
    }
  }
}

class HabitCard extends StatelessWidget {
  final DailyBlueprint data;
  final VoidCallback onDoNow;
  const HabitCard({super.key, required this.data, required this.onDoNow});

  @override
  Widget build(BuildContext context) {
    final action = switch (data.habit.type) {
      'journal' => '2–3 min reflection',
      'movement' => '2–3 min stretch',
      'social' => 'send a kind message',
      _ => 'micro-step',
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wellness micro-action',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('${data.habit.astroReason}.'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(action)),
                const Spacer(),
                FilledButton(onPressed: onDoNow, child: const Text('Do now')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReliefCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onStart;
  const ReliefCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.play_circle_fill),
        onTap: onStart,
      ),
    );
  }
}

extension on String {
  String capitalize() => isEmpty ? this : this[0].toUpperCase() + substring(1);
}
