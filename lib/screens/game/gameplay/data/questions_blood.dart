import '../../models/question_model.dart';

final List<QuestionModel> questionsBlood = [

  QuestionModel(
    question: "Apa itu hipoglikemia?",
    category: QuestionCategory.bloodSugar,
    options: [
      AnswerOption(text: "Gula darah rendah", score: 15, bloodDelta: 12),
      AnswerOption(text: "Gula darah tinggi", score: -5, bloodDelta: 0),
      AnswerOption(text: "Tubuh kebanyakan insulin", score: 5, bloodDelta: 2),
    ],
  ),

  QuestionModel(
    question: "Apa tanda gula darah terlalu tinggi?",
    category: QuestionCategory.bloodSugar,
    options: [
      AnswerOption(text: "Sering haus & buang air kecil", score: 12, bloodDelta: 5),
      AnswerOption(text: "Mengantuk sedikit", score: -2, bloodDelta: 0),
      AnswerOption(text: "Tidak ada tanda apa-apa", score: -5, bloodDelta: 0),
    ],
  ),

  QuestionModel(
    question: "Gula darah normal biasanya berada di kisaran…",
    category: QuestionCategory.bloodSugar,
    options: [
      AnswerOption(text: "70–140 mg/dL", score: 15, bloodDelta: 0),
      AnswerOption(text: "200–300 mg/dL", score: -8, bloodDelta: 0),
      AnswerOption(text: "Di atas 350 mg/dL", score: -12, bloodDelta: 0),
    ],
  ),
];
