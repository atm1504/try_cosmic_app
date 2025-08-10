import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/app_state.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/gradient_background.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final List<Task> suggestions =
        app.scheduledTasks.isEmpty ? <Task>[] : app.scheduledTasks;
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
              child: const Icon(Icons.schedule, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text('Plan'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(current: 1),
      body: SafeArea(
        child: GradientBackground(
          child: ListView(
            children: [
              const _ActivitySelector(),
              const SizedBox(height: 8),
              _SuggestionsList(
                  tasks: suggestions.isEmpty ? _mockFromApp(app) : suggestions),
            ],
          ),
        ),
      ),
    );
  }

  List<Task> _mockFromApp(AppState app) {
    return [
      ...app.scheduledTasks,
      ...?app.today?.windows.take(2).map((w) => Task(
            title: 'Right-time action',
            activity: 'conversation',
            suggestedWindows: [TaskWindow(start: w.start, end: w.end)],
          )),
    ];
  }
}

class _ActivitySelector extends StatefulWidget {
  const _ActivitySelector();

  @override
  State<_ActivitySelector> createState() => _ActivitySelectorState();
}

class _ActivitySelectorState extends State<_ActivitySelector> {
  String selected = 'conversation';
  @override
  Widget build(BuildContext context) {
    final items = [
      _Chip('Conversation', 'conversation'),
      _Chip('Application', 'application'),
      _Chip('Travel', 'travel'),
      _Chip('Ritual', 'ritual'),
      _Chip('Health', 'health'),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          spacing: 8,
          children: items
              .map((c) => ChoiceChip(
                    label: Text(c.label),
                    selected: selected == c.value,
                    onSelected: (_) => setState(() => selected = c.value),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _Chip {
  const _Chip(this.label, this.value);
  final String label;
  final String value;
}

class _SuggestionsList extends StatelessWidget {
  const _SuggestionsList({required this.tasks});
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Column(
      children: tasks.map((t) {
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(t.title),
                subtitle: Text('Why now: calm speech • clear of Rahu'),
                trailing: const Icon(Icons.info_outline),
              ),
              if (t.suggestedWindows.isNotEmpty)
                Column(
                  children: t.suggestedWindows
                      .map((w) => ListTile(
                            leading: const Icon(Icons.schedule),
                            title: Text(
                                '${TimeOfDay.fromDateTime(w.start).format(context)} – ${TimeOfDay.fromDateTime(w.end).format(context)}'),
                            trailing: FilledButton(
                              onPressed: () => app.scheduleTask(t, w.start),
                              child: const Text('Add to calendar'),
                            ),
                          ))
                      .toList(),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
