import 'package:flutter/material.dart';
import '../../../home_screen.dart';
import '../../../../main.dart';   // untuk akses MainNavigation
import '../gameplay_screen.dart';

class ResultScreen extends StatefulWidget {
  final int finalScore;
  final int correctAnswers;
  final int totalQuestions;
  final int bloodLevel;

  const ResultScreen({
    super.key,
    required this.finalScore,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.bloodLevel,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _scoreAnimController;
  late Animation<int> _scoreCounter;

  late AnimationController _fadeController;
  late Animation<double> _fadeIn;

  String arciExpression = "assets/images/bahagia.png";

  @override
  void initState() {
    super.initState();

    // Tentukan ekspresi Arci
    if (widget.finalScore >= 80) {
      arciExpression = "assets/images/bahagia.png";
    } else if (widget.finalScore >= 60) {
      arciExpression = "assets/images/badmood.png";
    } else if (widget.finalScore >= 40) {
      arciExpression = "assets/images/marah.png";
    } else {
      arciExpression = "assets/images/marahbesar.png";
    }

    // Animasi naik skor
    _scoreAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scoreCounter = IntTween(begin: 0, end: widget.finalScore).animate(
      CurvedAnimation(parent: _scoreAnimController, curve: Curves.easeOutCubic),
    );

    _scoreAnimController.forward();

    // Fade transition
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _fadeIn = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _scoreAnimController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(   // <-- FULL CENTER
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Arci expression
                SizedBox(height: 180, child: Image.asset(arciExpression)),

                const SizedBox(height: 20),

                const Text(
                  "Hasil Permainanmu!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 16),

                AnimatedBuilder(
                  animation: _scoreCounter,
                  builder: (context, child) {
                    return Text(
                      "${_scoreCounter.value}",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                const Text(
                  "Total Skor",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),

                const SizedBox(height: 20),

                Text(
                  "Jawaban Benar: ${widget.correctAnswers}/${widget.totalQuestions}",
                  style: const TextStyle(fontSize: 16),
                ),

                Text(
                  "Stabilitas Gula Darah: ${widget.bloodLevel}",
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.bloodLevel >= 0 ? Colors.green : Colors.red,
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const GameplayScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  child: const Text(
                    "Main Lagi",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                const SizedBox(height: 16),

                // ⭐ FIX BUTTON KE HOME + NAVBAR TIDAK HILANG
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainNavigation()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Kembali ke Home",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
