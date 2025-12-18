class BloodLogic {
  /// Rentang 0 – 100, kita mulai dari 50 (netral)
  int bloodLevel;

  BloodLogic({this.bloodLevel = 50});

  void applyDelta(int delta) {
    bloodLevel += delta;
    if (bloodLevel > 100) bloodLevel = 100;
    if (bloodLevel < 0) bloodLevel = 0;
  }

  /// Status sederhana berdasarkan level
  String get statusText {
    if (bloodLevel <= 30) return "Terlalu Rendah";
    if (bloodLevel >= 70) return "Terlalu Tinggi";
    return "Stabil";
  }

  /// Untuk warna indikator (bisa dipakai di UI)
  int get statusType {
    // 0 = low, 1 = normal, 2 = high
    if (bloodLevel <= 30) return 0;
    if (bloodLevel >= 70) return 2;
    return 1;
  }
}
