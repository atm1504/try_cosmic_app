import 'dart:convert';

class DailyBlueprint {
  final DateTime date;
  final String zodiac;
  final String moonPhase;
  final DayColor color;
  final String focus;
  final List<TimeWindow> windows;
  final TimeWindow avoid;
  final Habit habit;

  const DailyBlueprint({
    required this.date,
    required this.zodiac,
    required this.moonPhase,
    required this.color,
    required this.focus,
    required this.windows,
    required this.avoid,
    required this.habit,
  });

  factory DailyBlueprint.fromJson(Map<String, dynamic> json) {
    return DailyBlueprint(
      date: DateTime.parse(json['date'] as String),
      zodiac: json['zodiac'] as String,
      moonPhase: json['moon_phase'] as String,
      color: DayColor.fromJson(json['color'] as Map<String, dynamic>),
      focus: json['focus'] as String,
      windows: (json['windows'] as List<dynamic>)
          .map((e) => TimeWindow.fromJson(e as Map<String, dynamic>))
          .toList(),
      avoid: TimeWindow.fromJson(json['avoid'] as Map<String, dynamic>),
      habit: Habit.fromJson(json['habit'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String().split('T').first,
        'zodiac': zodiac,
        'moon_phase': moonPhase,
        'color': color.toJson(),
        'focus': focus,
        'windows': windows.map((e) => e.toJson()).toList(),
        'avoid': avoid.toJson(),
        'habit': habit.toJson(),
      };

  static DailyBlueprint demo(DateTime date) {
    return DailyBlueprint(
      date: date,
      zodiac: 'Virgo',
      moonPhase: 'Waxing Crescent',
      color: const DayColor(value: 'green', planet: 'Mercury'),
      focus: 'Clarity',
      windows: const [
        TimeWindow(
            start: '10:12+05:30',
            end: '11:05+05:30',
            reason: ['Mercury hora', 'No Rahu']),
        TimeWindow(
            start: '14:20+05:30',
            end: '15:00+05:30',
            reason: ['Guru hora', 'Moon trine Jupiter']),
      ],
      avoid: const TimeWindow(
          start: '13:00+05:30', end: '13:45+05:30', reason: ['Rahu Kaal']),
      habit: const Habit(
          type: 'journal', astroReason: 'Mercury in Virgo — focus on writing'),
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}

class DayColor {
  final String value;
  final String planet;
  const DayColor({required this.value, required this.planet});

  factory DayColor.fromJson(Map<String, dynamic> json) => DayColor(
      value: json['value'] as String, planet: json['planet'] as String);
  Map<String, dynamic> toJson() => {'value': value, 'planet': planet};
}

class TimeWindow {
  final String start; // "10:12+05:30"
  final String end;
  final List<String> reason;
  const TimeWindow(
      {required this.start, required this.end, required this.reason});

  factory TimeWindow.fromJson(Map<String, dynamic> json) => TimeWindow(
        start: json['start'] as String,
        end: json['end'] as String,
        reason: (json['reason'] is String)
            ? [json['reason'] as String]
            : (json['reason'] as List<dynamic>).cast<String>(),
      );
  Map<String, dynamic> toJson() =>
      {'start': start, 'end': end, 'reason': reason};
}

class Habit {
  final String type; // journal | movement | social
  final String astroReason;
  const Habit({required this.type, required this.astroReason});

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
      type: json['type'] as String,
      astroReason: json['astro_reason'] as String);
  Map<String, dynamic> toJson() => {'type': type, 'astro_reason': astroReason};
}
