class CarePathEnrollment {
  CarePathEnrollment({
    required this.userId,
    required this.path,
    required this.day,
    required this.stage,
    required this.todayCardId,
  });

  final String userId;
  final String path; // breakup, layoff, bereavement, burnout
  final int day;
  final String stage; // e.g., process
  final String todayCardId;
}

class CarePathCard {
  CarePathCard({
    required this.id,
    required this.title,
    required this.validate,
    required this.action,
    required this.reflect,
    this.ritual,
  });

  final String id;
  final String title;
  final String validate; // text
  final String action; // text / steps
  final String reflect; // text / prompt
  final String? ritual; // optional
}
