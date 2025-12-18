// ===============================
// QUESTION MODEL FOR GAMEPLAY
// ===============================

// ✔ Kategori pertanyaan
enum QuestionCategory {
  habits,          // kebiasaan hidup
  food,            // makanan
  insulin,         // edukasi insulin
  activity,        // aktivitas fisik
  bloodSugar,      // pemahaman gula darah
}

// ✔ Model untuk 1 opsi jawaban
class AnswerOption {
  final String text;       // teks pilihan jawaban
  final int score;         // nilai + / - untuk skor total pemain
  final int bloodDelta;    // perubahan gula darah (+ naik / - turun)

  AnswerOption({
    required this.text,
    required this.score,
    required this.bloodDelta,
  });
}

// ✔ Model untuk 1 pertanyaan lengkap
class QuestionModel {
  final String question;                 // pertanyaannya
  final QuestionCategory category;       // kategori (habits / food / dll)
  final List<AnswerOption> options;      // daftar pilihan jawaban

  QuestionModel({
    required this.question,
    required this.category,
    required this.options,
  });
}

// =====================================
// OPTIONAL: Helper for converting enum
// =====================================
String categoryToText(QuestionCategory cat) {
  switch (cat) {
    case QuestionCategory.habits:
      return "Kebiasaan";
    case QuestionCategory.food:
      return "Makanan";
    case QuestionCategory.insulin:
      return "Insulin";
    case QuestionCategory.activity:
      return "Aktivitas";
    case QuestionCategory.bloodSugar:
      return "Gula Darah";
  }
}
