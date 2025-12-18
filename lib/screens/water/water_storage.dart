import 'package:shared_preferences/shared_preferences.dart';

class WaterStorage {
  static const String keyWaterMl = "water_today_ml";

  static Future<int> loadWater() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyWaterMl) ?? 0;
  }

  static Future<void> saveWater(int ml) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyWaterMl, ml);
  }

  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyWaterMl, 0);
  }
}
