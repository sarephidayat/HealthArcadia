import '../../models/question_model.dart';

final List<QuestionModel> questionsInsulin = [

  QuestionModel(
    question: "Apa fungsi utama insulin bagi tubuh Arci?",
    category: QuestionCategory.insulin,
    options: [
      AnswerOption(text: "Memasukkan gula ke sel", score: 15, bloodDelta: -5),
      AnswerOption(text: "Menaikkan gula darah", score: -8, bloodDelta: 10),
      AnswerOption(text: "Menghilangkan rasa lapar", score: -3, bloodDelta: 1),
    ],
  ),

  QuestionModel(
    question: "Kapan Arci harus mengambil insulin?",
    category: QuestionCategory.insulin,
    options: [
      AnswerOption(text: "Sesuai jadwal dokter", score: 15, bloodDelta: -3),
      AnswerOption(text: "Saat merasa ngantuk", score: -5, bloodDelta: 2),
      AnswerOption(text: "Setiap 10 menit", score: -10, bloodDelta: 12),
    ],
  ),

  QuestionModel(
    question: "Apa akibat lupa suntik insulin?",
    category: QuestionCategory.insulin,
    options: [
      AnswerOption(text: "Gula naik berbahaya", score: -10, bloodDelta: 20),
      AnswerOption(text: "Tidak ada efek", score: -5, bloodDelta: 0),
      AnswerOption(text: "Membuat lebih kuat", score: -8, bloodDelta: 5),
    ],
  ),
];
