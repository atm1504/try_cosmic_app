import 'package:flutter/material.dart';
import 'app.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  final notificationService = NotificationService();
  await notificationService.init();
  runApp(const App());
}
