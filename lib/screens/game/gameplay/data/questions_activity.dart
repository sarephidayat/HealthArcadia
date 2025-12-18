import '../../models/question_model.dart';

final List<QuestionModel> questionsActivity = [

  QuestionModel(
    question: "Aktivitas mana yang baik untuk Arci?",
    category: QuestionCategory.activity,
    options: [
      AnswerOption(text: "Jalan kaki 20 menit", score: 12, bloodDelta: -2),
      AnswerOption(text: "Main game di kasur", score: -2, bloodDelta: 1),
      AnswerOption(text: "Lari sprint 10 menit tanpa persiapan", score: -5, bloodDelta: 8),
    ],
  ),

  QuestionModel(
    question: "Kapan Arci harus berhenti berolahraga?",
    category: QuestionCategory.activity,
    options: [
      AnswerOption(text: "Saat merasa pusing/bergetar", score: 10, bloodDelta: 3),
      AnswerOption(text: "Saat masih kuat", score: -3, bloodDelta: -1),
      AnswerOption(text: "Tidak perlu berhenti", score: -8, bloodDelta: 6),
    ],
  ),

  QuestionModel(
    question: "Sebelum olahraga Arci harus…",
    category: QuestionCategory.activity,
    options: [
      AnswerOption(text: "Cek gula darah", score: 12, bloodDelta: -1),
      AnswerOption(text: "Langsung gas tanpa cek", score: -4, bloodDelta: 6),
      AnswerOption(text: "Minum minuman energi", score: -6, bloodDelta: 12),
    ],
  ),
];
