import 'dart:math';

import '../models/daily_blueprint.dart';
import '../models/plan_models.dart';

class AstroService {
  // Placeholder: in a real app, call an ephemeris/astro API.
  DailyBlueprint getDailyBlueprint({required DateTime forDate}) {
    return DailyBlueprint.demo(forDate);
  }

  List<RightTimeSlot> findRightTimeSlots({
    required ActivityKind activity,
    required DateTime from,
    required int days,
  }) {
    final random = Random(from.millisecondsSinceEpoch);
    final List<RightTimeSlot> slots = [];
    for (int d = 0; d < days; d++) {
      final base = DateTime(from.year, from.month, from.day + d, 9);
      for (int i = 0; i < 3; i++) {
        final start = base.add(Duration(hours: 2 * i + random.nextInt(2)));
        final end = start.add(Duration(minutes: 20 + random.nextInt(40)));
        final score = 70 + random.nextInt(30);
        final reasons = [
          if (i == 0) 'Guru hora' else 'Mercury hora',
          if (d.isEven) 'Waxing Moon' else 'Moon trine Jupiter',
          'No Rahu overlap',
        ];
        slots.add(RightTimeSlot(
          start: start,
          end: end,
          score: score,
          reasons: reasons,
          activityType: activity.label,
        ));
      }
    }
    slots.sort((a, b) => b.score.compareTo(a.score));
    return slots.take(3).toList();
  }
}
