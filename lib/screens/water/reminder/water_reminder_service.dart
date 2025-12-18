import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'water_reminder_storage.dart';

class WaterReminderService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notifikasi
  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _plugin.initialize(settings);
  }

  // Set reminder tiap X jam
  static Future<void> setReminder(int intervalHours) async {
    await cancelReminder();

    await _plugin.periodicallyShow(
      0,
      "Ayo Minum Air 💧",
      "Jangan lupa minum air untuk memenuhi target harianmu!",
      RepeatInterval.hourly,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "water_channel",
          "Water Reminder",
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
    );
  }

  static Future<void> cancelReminder() async {
    await _plugin.cancelAll();
  }
}
