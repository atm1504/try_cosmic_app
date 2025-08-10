import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/bottom_nav.dart';

class RecoverScreen extends StatelessWidget {
  const RecoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Recover')),
      bottomNavigationBar: const BottomNav(current: 2),
      body: SafeArea(
        child: ListView(
          children: [
            const _Tabs(),
            if (app.carePath != null) const _TodayCard(),
          ],
        ),
      ),
    );
  }
}

class _Tabs extends StatefulWidget {
  const _Tabs();

  @override
  State<_Tabs> createState() => _TabsState();
}

class _TabsState extends State<_Tabs> with TickerProviderStateMixin {
  late final TabController _controller = TabController(length: 4, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Breakup'),
            Tab(text: 'Layoff'),
            Tab(text: 'Bereavement'),
            Tab(text: 'Burnout'),
          ],
        ),
        SizedBox(
          height: 120,
          child: TabBarView(
            controller: _controller,
            children: const [
              _PathCard('Day 3 of 30 • Today: No-contact hour'),
              _PathCard('Get steady • Gentle structure'),
              _PathCard('Be with what is • Simple ritual'),
              _PathCard('Refuel • Boundaries • Micro-wins'),
            ],
          ),
        ),
      ],
    );
  }
}

class _PathCard extends StatelessWidget {
  const _PathCard(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Center(child: Text(text)),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Breakup • Day 3',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text(
                'Validate: It’s okay if urges spike today. You’re not failing.'),
            const SizedBox(height: 8),
            const Text(
                'Action (3 min): Boundary script practice you won’t send.'),
            const SizedBox(height: 8),
            const Text('Reflect (1 min): What felt doable?'),
            const SizedBox(height: 12),
            Row(children: [
              FilledButton(onPressed: () {}, child: const Text('Do now')),
              const SizedBox(width: 12),
              OutlinedButton(onPressed: () {}, child: const Text('Right‑time')),
            ])
          ],
        ),
      ),
    );
  }
}
