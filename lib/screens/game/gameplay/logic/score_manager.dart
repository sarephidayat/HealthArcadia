class ScoreManager {
  int score = 0;
  int questionsAnswered = 0;

  /// Untuk penilaian sederhana:
  /// Jika delta mendekatkan ke range 40–60, anggap “baik”.
  void addScore({
    required int previousBlood,
    required int newBlood,
  }) {
    questionsAnswered++;

    final int target = 50;
    final int before = (previousBlood - target).abs();
    final int after = (newBlood - target).abs();

    if (after < before) {
      score += 10;    // keputusan bagus
    } else if (after == before) {
      score += 5;     // netral
    } else {
      score += 0;     // keputusan kurang baik
    }
  }

  String get scoreLabel {
    if (score >= 80) return "Dokter Hebat!";
    if (score >= 50) return "Penjaga Gula Andal!";
    return "Masih Perlu Latihan";
  }
}
