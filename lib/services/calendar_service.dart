import 'package:add_2_calendar/add_2_calendar.dart';

class CalendarService {
  Future<void> addEventToCalendar({
    required String title,
    required DateTime start,
    required DateTime end,
    String? description,
    String? location,
  }) async {
    final event = Event(
      title: title,
      startDate: start,
      endDate: end,
      description: description,
      location: location,
      iosParams: const IOSParams(reminder: Duration(minutes: 20)),
      androidParams: const AndroidParams(emailInvites: []),
    );
    await Add2Calendar.addEvent2Cal(event);
  }
}
