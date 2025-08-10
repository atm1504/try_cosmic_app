import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/mock_data_service.dart';
import '../models/models.dart';

class AppState extends ChangeNotifier {
  final MockDataService _data = MockDataService();

  Profile? profile;
  DailySnapshot? today;
  List<Task> scheduledTasks = [];
  CarePathEnrollment? carePath;
  int selectedTabIndex = 0;

  Future<void> initialize() async {
    profile = await _data.loadProfile();
    today = await _data.loadToday();
    scheduledTasks = await _data.loadTasks();
    carePath = await _data.loadCarePath();
    notifyListeners();
  }

  void setTab(int index) {
    if (index == selectedTabIndex) return;
    selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> scheduleTask(Task task, DateTime start) async {
    final updated = task.copyWith(
      chosen:
          TaskWindow(start: start, end: start.add(const Duration(minutes: 40))),
      status: TaskStatus.scheduled,
      id: task.id ?? const Uuid().v4(),
    );
    await _data.saveTask(updated);
    scheduledTasks = await _data.loadTasks();
    notifyListeners();
  }

  Future<void> markTaskDone(String taskId) async {
    await _data.markTaskDone(taskId);
    scheduledTasks = await _data.loadTasks();
    notifyListeners();
  }

  Future<void> logTinyWin(String text) async {
    await _data.saveTinyWin(text);
  }
}
