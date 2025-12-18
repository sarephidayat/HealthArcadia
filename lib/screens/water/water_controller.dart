import 'water_storage.dart';
import 'water_constants.dart';

class WaterController {
  int currentMl = 0;

  // Load data dari SharedPreferences
  Future<void> loadWater() async {
    currentMl = await WaterStorage.loadWater();
  }

  // Tambah minum
  Future<void> addWater(int amount) async {
    currentMl += amount;
    if (currentMl > WaterConstants.dailyGoalMl) {
      currentMl = WaterConstants.dailyGoalMl;
    }
    await WaterStorage.saveWater(currentMl);
  }

  // Reset harian
  Future<void> resetWater() async {
    currentMl = 0;
    await WaterStorage.reset();
  }
}
