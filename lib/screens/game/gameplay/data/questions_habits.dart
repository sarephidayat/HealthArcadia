import '../../models/question_model.dart';

final List<QuestionModel> questionsHabits = [

  QuestionModel(
    question: "Arci baru bangun tidur. Apa kebiasaan pertama yang sebaiknya dilakukan?",
    category: QuestionCategory.habits,
    options: [
      AnswerOption(text: "Cek gula darah", score: 10, bloodDelta: -1),
      AnswerOption(text: "Langsung sarapan", score: -3, bloodDelta: 4),
      AnswerOption(text: "Minum kopi hitam", score: 0, bloodDelta: 1),
    ],
  ),

  QuestionModel(
    question: "Arci sibuk bekerja dan lupa minum air seharian. Apa dampaknya?",
    category: QuestionCategory.habits,
    options: [
      AnswerOption(text: "Gula darah bisa naik", score: -5, bloodDelta: 8),
      AnswerOption(text: "Tidak ada dampak", score: -2, bloodDelta: 2),
      AnswerOption(text: "Bikin ngantuk saja", score: -1, bloodDelta: 3),
    ],
  ),

  QuestionModel(
    question: "Arci merasa stres. Apa yang sebaiknya dilakukan?",
    category: QuestionCategory.habits,
    options: [
      AnswerOption(text: "Tarik napas dan istirahat", score: 10, bloodDelta: -2),
      AnswerOption(text: "Makan coklat banyak", score: -4, bloodDelta: 6),
      AnswerOption(text: "Tidur seharian", score: -1, bloodDelta: 1),
    ],
  ),

  QuestionModel(
    question: "Berapa kali Arci sebaiknya cek gula darah dalam sehari?",
    category: QuestionCategory.habits,
    options: [
      AnswerOption(text: "1 kali", score: -2, bloodDelta: 2),
      AnswerOption(text: "2–4 kali sesuai anjuran", score: 12, bloodDelta: -1),
      AnswerOption(text: "Tidak perlu, cukup feeling saja", score: -8, bloodDelta: 6),
    ],
  ),

  QuestionModel(
    question: "Arci lupa membawa permen/dextrose saat keluar rumah. Kenapa ini berbahaya?",
    category: QuestionCategory.habits,
    options: [
      AnswerOption(
        text: "Jika hipo, tidak ada penanganan cepat",
        score: -6,
        bloodDelta: -12,
      ),
      AnswerOption(
        text: "Gula darah bisa meledak",
        score: -2,
        bloodDelta: 1,
      ),
      AnswerOption(
        text: "Tidak pengaruh apa-apa",
        score: -5,
        bloodDelta: 3,
      ),
    ],
  ),
];
