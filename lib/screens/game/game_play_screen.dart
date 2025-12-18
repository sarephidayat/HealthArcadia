import 'package:flutter/material.dart';
import 'package:healtharcadia/screens/game/game_result_screen.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  double sugarLevel = 50; // 0–100
  String maskotAsset = "assets/images/bahagia.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Gula Darah Adventure",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ====== METER GULA DARAH ======
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Kadar Gula Darah",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: sugarLevel / 100,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade300,
                  color: _sugarColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: 4),
                Text(
                  "${sugarLevel.toInt()} / 100",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ====== MASKOT ======
            SizedBox(
              height: 150,
              child: Image.asset(maskotAsset),
            ),

            const SizedBox(height: 20),

            // ====== KOTAK PERTANYAAN ======
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                "Kamu baru selesai makan siang. Apa langkah terbaik agar gula darah tetap stabil?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // ====== PILIHAN JAWABAN ======
            _answerButton(
              "Suntik insulin sesuai dosis & cek gula darah",
              true,
            ),
            _answerButton(
              "Minum es teh manis dan duduk santai",
              false,
            ),
            _answerButton(
              "Tidak melakukan apa-apa",
              false,
            ),
          ],
        ),
      ),
    );
  }

  Color _sugarColor() {
    if (sugarLevel < 30) return Colors.blue;
    if (sugarLevel <= 70) return Colors.green;
    return Colors.red;
  }

  Widget _answerButton(String text, bool isCorrect) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // nanti di sini kita isi logic update sugarLevel + maskot
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const GameResultScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
