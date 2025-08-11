import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String moodBoxName = 'moods';
  static const String journalBoxName = 'journals';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<int>(moodBoxName);
    await Hive.openBox<String>(journalBoxName);
  }

  Future<void> saveMood(DateTime dateTime, int moodValue) async {
    final box = Hive.box<int>(moodBoxName);
    await box.put(dateTime.toIso8601String(), moodValue);
  }

  Future<void> saveJournal(DateTime dateTime, String note) async {
    final box = Hive.box<String>(journalBoxName);
    await box.put(dateTime.toIso8601String(), note);
  }
}
