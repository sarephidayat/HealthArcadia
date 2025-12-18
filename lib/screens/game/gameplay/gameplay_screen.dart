import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'screens/result_screen.dart';

// import data pertanyaan
import 'data/questions_habits.dart';
import 'data/questions_food.dart';
import 'data/questions_insulin.dart';
import 'data/questions_activity.dart';
import 'data/questions_blood.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen>
    with TickerProviderStateMixin {

  int questionIndex = 0;
  int score = 0;
  int bloodLevel = 0;
  int correct = 0;

  late List<QuestionModel> allQuestions;

  // Arci animation
  late AnimationController _arciAnim;
  late Animation<double> _arciBounce;

  String arciFace = "assets/images/bahagia.png";

  @override
  void initState() {
    super.initState();

    // ===== GABUNGKAN SEMUA PERTANYAAN =====
    allQuestions = [
      ...questionsHabits,
      ...questionsFood,
      ...questionsInsulin,
      ...questionsActivity,
      ...questionsBlood,
    ]..shuffle();

    // ===== ANIMASI ARCI =====
    _arciAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _arciBounce = Tween<double>(begin: 0, end: -12).animate(
      CurvedAnimation(parent: _arciAnim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _arciAnim.dispose();
    super.dispose();
  }

  // ================================
  // LOGIKA KETIKA USER PILIH JAWABAN
  // ================================
  void selectAnswer(AnswerOption answer) {
    setState(() {
      score += answer.score;
      bloodLevel += answer.bloodDelta;

      // ekspresi Arci
      if (bloodLevel > 25) {
        arciFace = "assets/images/badmood.png";
      } else if (bloodLevel < -20) {
        arciFace = "assets/images/sedih.png";
      } else {
        arciFace = "assets/images/bahagia.png";
      }

      // hitung benar
      if (answer.score > 0) correct++;

      // next question / selesai
      if (questionIndex < allQuestions.length - 1) {
        questionIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              finalScore: score,
              correctAnswers: correct,
              totalQuestions: allQuestions.length,
              bloodLevel: bloodLevel,
            ),
          ),
        );
      }
    });
  }

  // ================================
  // UI
  // ================================
  @override
  Widget build(BuildContext context) {
    final question = allQuestions[questionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Title blood bar
              Text(
                "Stabilitas Gula Darah",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),
              bloodBar(),

              const SizedBox(height: 20),

              // Maskot animasi
              AnimatedBuilder(
                animation: _arciAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _arciBounce.value),
                    child: child,
                  );
                },
                child: SizedBox(
                  height: 180,
                  child: Image.asset(arciFace),
                ),
              ),

              const SizedBox(height: 18),

              // PERTANYAAN
              Text(
                question.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              // PILIHAN JAWABAN
              ...question.options.map((o) => answerButton(o)),
            ],
          ),
        ),
      ),
    );
  }

  // ================================
  // BLOOD BAR
  // ================================
  Widget bloodBar() {
    double normalized = (bloodLevel + 100) / 200;

    return Container(
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade300,
      ),
      child: FractionallySizedBox(
        widthFactor: normalized.clamp(0.0, 1.0),
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: bloodLevel.abs() < 20
                ? Colors.green
                : bloodLevel > 20
                    ? Colors.red
                    : Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ================================
  // TOMBOL JAWABAN
  // ================================
  Widget answerButton(AnswerOption o) {
    return GestureDetector(
      onTap: () => selectAnswer(o),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Text(
          o.text,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
