import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int score;
  final int currentQuestion;
  final int totalQuestions;
  final int bloodLevel; // rentang -100 sampai +100
  final String status; // "stabil", "tinggi", "rendah"

  const ScoreBoard({
    super.key,
    required this.score,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.bloodLevel,
    required this.status,
  });

  Color getBloodColor() {
    if (status == "tinggi") return Colors.red;
    if (status == "rendah") return Colors.blue;
    return Colors.green; // stabil
  }

  IconData getBloodIcon() {
    if (status == "tinggi") return Icons.bloodtype_rounded;
    if (status == "rendah") return Icons.water_drop;
    return Icons.favorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SCORE
          Column(
            children: [
              const Text(
                "Skor",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                score.toString(),
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          // PROGRESS
          Column(
            children: [
              const Text(
                "Pertanyaan",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                "$currentQuestion / $totalQuestions",
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // BLOOD LEVEL
          Column(
            children: [
              Icon(getBloodIcon(), color: getBloodColor(), size: 30),
              Text(
                status.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  color: getBloodColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
