import '../models/models.dart';

class MockDataService {
  Future<Profile> loadProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return Profile.mock();
  }

  Future<DailySnapshot> loadToday() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final now = DateTime.now();
    final start1 = DateTime(now.year, now.month, now.day, 10, 12);
    final end1 = start1.add(const Duration(minutes: 53));
    final start2 = DateTime(now.year, now.month, now.day, 14, 20);
    final end2 = start2.add(const Duration(minutes: 40));
    final avoid = DateTime(now.year, now.month, now.day, 16, 30);
    final avoidEnd = avoid.add(const Duration(minutes: 45));
    return DailySnapshot(
      date: DateTime(now.year, now.month, now.day),
      windows: [
        WindowScore(
            start: start1,
            end: end1,
            score: 0.82,
            why: const ['Mercury hour', 'No Rahu']),
        WindowScore(
            start: start2,
            end: end2,
            score: 0.78,
            why: const ['Moon waxing', 'Friendly weekday lord']),
        WindowScore(
            start: avoid,
            end: avoidEnd,
            score: 0.12,
            why: const ['Rahu window']),
      ],
      color: 'white',
      focus: 'Clarity in conversations',
      habitId: 'breathing_box_4_4_4_4',
    );
  }

  Future<List<Task>> loadTasks() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final now = DateTime.now();
    final suggestions = [
      Task(
        title: 'Call manager',
        activity: 'conversation',
        suggestedWindows: [
          TaskWindow(
              start: DateTime(now.year, now.month, now.day, 14, 20),
              end: DateTime(now.year, now.month, now.day, 15, 0)),
          TaskWindow(
              start: DateTime(now.year, now.month, now.day, 17, 10),
              end: DateTime(now.year, now.month, now.day, 17, 50)),
        ],
      ),
      Task(
        title: 'Gym session',
        activity: 'health',
        suggestedWindows: [
          TaskWindow(
              start: DateTime(now.year, now.month, now.day, 18, 0),
              end: DateTime(now.year, now.month, now.day, 19, 0)),
        ],
      ),
    ];
    return suggestions;
  }

  Future<CarePathEnrollment?> loadCarePath() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return CarePathEnrollment(
      userId: 'uuid',
      path: 'breakup',
      day: 3,
      stage: 'process',
      todayCardId: 'bkup_d3',
    );
  }

  final List<Task> _persisted = [];

  Future<void> saveTask(Task task) async {
    _persisted.removeWhere((t) => t.id == task.id);
    _persisted.add(task);
  }

  Future<void> markTaskDone(String taskId) async {
    final idx = _persisted.indexWhere((t) => t.id == taskId);
    if (idx != -1) {
      _persisted[idx] = _persisted[idx].copyWith(status: TaskStatus.done);
    }
  }

  Future<void> saveTinyWin(String text) async {
    // No-op mock, could append to in-memory list
  }
}
