class DailySnapshot {
  DailySnapshot({
    required this.date,
    required this.windows,
    required this.color,
    required this.focus,
    required this.habitId,
  });

  final DateTime date;
  final List<WindowScore> windows;
  final String color;
  final String focus;
  final String habitId;
}

class WindowScore {
  WindowScore(
      {required this.start,
      required this.end,
      required this.score,
      required this.why});
  final DateTime start;
  final DateTime end;
  final double score; // 0..1
  final List<String> why;
}
