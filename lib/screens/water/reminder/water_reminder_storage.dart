import 'package:shared_preferences/shared_preferences.dart';

class WaterReminderStorage {
  static const keyEnabled = "water_reminder_enabled";
  static const keyInterval = "water_reminder_interval";

  static Future<bool> loadEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyEnabled) ?? false;
  }

  static Future<void> saveEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyEnabled, value);
  }

  static Future<int> loadInterval() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyInterval) ?? 2; // default: setiap 2 jam
  }

  static Future<void> saveInterval(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyInterval, value);
  }
}
