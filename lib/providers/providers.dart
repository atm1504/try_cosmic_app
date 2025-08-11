import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/daily_blueprint.dart';
import '../models/plan_models.dart';
import '../services/astro_service.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import '../services/calendar_service.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final astroServiceProvider = Provider<AstroService>((ref) {
  return AstroService();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final calendarServiceProvider = Provider<CalendarService>((ref) {
  return CalendarService();
});

final dailyBlueprintProvider = FutureProvider<DailyBlueprint>((ref) async {
  // NOTE: In real app, depends on user profile and location.
  final astro = ref.read(astroServiceProvider);
  return astro.getDailyBlueprint(forDate: DateTime.now());
});

final rightTimeSlotsProvider = FutureProvider.autoDispose
    .family<List<RightTimeSlot>, ActivityKind>((ref, activity) async {
  final astro = ref.read(astroServiceProvider);
  return astro.findRightTimeSlots(
    activity: activity,
    from: DateTime.now(),
    days: 7,
  );
});
