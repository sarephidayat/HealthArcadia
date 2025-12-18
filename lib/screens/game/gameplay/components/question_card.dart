import 'package:flutter/material.dart';
import '../../models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final GameQuestion question;
  final void Function(GameOption) onSelect;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              question.scenario,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 18),

            ...question.options.map((opt) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Colors.redAccent),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => onSelect(opt),
                  child: Text(
                    opt.text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
