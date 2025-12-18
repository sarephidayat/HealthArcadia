import 'package:flutter/material.dart';
import 'opening_animation_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: FadeTransition(
        opacity: _fadeIn,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MASKOT ARCI
              SizedBox(
                height: 220,
                child: Image.asset(
                  "assets/images/bahagia.png",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              // JUDUL GAME
              const Text(
                "Petualangan Arci!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 10),

              // DESKRIPSI GAME
              const Text(
                "Bantu Arci menjaga kadar gula darah tetap stabil!\n"
                "Pilih makanan, aktivitas, dan keputusan yang tepat\n"
                "dalam perjalanan penuh tantangan ini.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 35),

              // TOMBOL MULAI GAME
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OpeningAnimationScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Mulai Petualangan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
