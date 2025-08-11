class RightTimeSlot {
  final DateTime start;
  final DateTime end;
  final int score; // 0-100
  final List<String>
      reasons; // e.g., ["Guru hora", "Waxing Moon", "Mercury direct"]
  final String activityType; // e.g., conversation, travel, ritual

  const RightTimeSlot({
    required this.start,
    required this.end,
    required this.score,
    required this.reasons,
    required this.activityType,
  });
}

enum ActivityKind {
  conversation,
  jobApplication,
  travel,
  health,
  ritual,
  study
}

extension ActivityKindX on ActivityKind {
  String get label => switch (this) {
        ActivityKind.conversation => 'Conversation',
        ActivityKind.jobApplication => 'Job Application',
        ActivityKind.travel => 'Travel',
        ActivityKind.health => 'Health',
        ActivityKind.ritual => 'Ritual',
        ActivityKind.study => 'Study',
      };
}
