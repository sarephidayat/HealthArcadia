import '../../models/question_model.dart';

final List<QuestionModel> questionsFood = [

  QuestionModel(
    question: "Arci ingin sarapan. Mana pilihan paling aman?",
    category: QuestionCategory.food,
    options: [
      AnswerOption(text: "Oatmeal  buah", score: 12, bloodDelta: -2),
      AnswerOption(text: "Nasi goreng pedas", score: -5, bloodDelta: 15),
      AnswerOption(text: "Donat  kopi manis", score: -8, bloodDelta: 20),
    ],
  ),

  QuestionModel(
    question: "Arci ingin ngemil. Mana yang paling aman?",
    category: QuestionCategory.food,
    options: [
      AnswerOption(text: "Kacang almond", score: 10, bloodDelta: -1),
      AnswerOption(text: "Keripik kentang", score: -5, bloodDelta: 10),
      AnswerOption(text: "Minuman boba", score: -10, bloodDelta: 25),
    ],
  ),

  QuestionModel(
    question: "Makanan apa yang sebaiknya dihindari Arci?",
    category: QuestionCategory.food,
    options: [
      AnswerOption(text: "Roti gandum", score: 5, bloodDelta: 2),
      AnswerOption(text: "Minuman bersoda", score: -12, bloodDelta: 30),
      AnswerOption(text: "Sayur rebus", score: 8, bloodDelta: -1),
    ],
  ),

  QuestionModel(
    question: "Saat gula darah rendah (hipo), Arci harus konsumsi…",
    category: QuestionCategory.food,
    options: [
      AnswerOption(text: "Permen atau glukosa cepat", score: 12, bloodDelta: 12),
      AnswerOption(text: "Steak daging", score: -4, bloodDelta: 1),
      AnswerOption(text: "Air putih saja", score: -6, bloodDelta: 0),
    ],
  ),
];
