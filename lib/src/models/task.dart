enum TaskStatus { suggested, scheduled, done }

class TaskWindow {
  TaskWindow({required this.start, required this.end});
  final DateTime start;
  final DateTime end;
}

class Task {
  Task({
    this.id,
    required this.title,
    required this.activity,
    required this.suggestedWindows,
    this.chosen,
    this.status = TaskStatus.suggested,
  });

  final String? id;
  final String title;
  final String activity; // conversation, application, travel, ritual, health
  final List<TaskWindow> suggestedWindows;
  final TaskWindow? chosen;
  final TaskStatus status;

  Task copyWith({
    String? id,
    String? title,
    String? activity,
    List<TaskWindow>? suggestedWindows,
    TaskWindow? chosen,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      activity: activity ?? this.activity,
      suggestedWindows: suggestedWindows ?? this.suggestedWindows,
      chosen: chosen ?? this.chosen,
      status: status ?? this.status,
    );
  }
}
