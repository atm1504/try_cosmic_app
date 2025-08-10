class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.birth,
    required this.timezone,
    required this.goals,
    required this.tone,
  });

  final String id;
  final String name;
  final Birth birth;
  final String timezone;
  final List<String> goals;
  final String tone; // 'classic' | 'light'

  factory Profile.mock() => Profile(
        id: 'uuid',
        name: 'Aarav',
        birth: Birth(date: '1995-05-19', time: '14:22', place: 'Patna, IN'),
        timezone: 'Asia/Kolkata',
        goals: const ['stress', 'focus'],
        tone: 'light',
      );
}

class Birth {
  Birth({required this.date, required this.time, required this.place});
  final String date; // yyyy-MM-dd
  final String time; // HH:mm
  final String place;
}
