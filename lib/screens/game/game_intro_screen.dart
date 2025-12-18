import 'package:flutter/material.dart';
import 'intro/intro_page1.dart';

class GameIntroScreen extends StatefulWidget {
  const GameIntroScreen({super.key});

  @override
  State<GameIntroScreen> createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    // ANIMASI BOUNCE MASKOT
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: -12).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Fade in untuk teks & tombol
    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    );
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

      // ====== CENTER FULL ======
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            mainAxisSize: MainAxisSize.min,     // 👈 INI KUNCI CENTER
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              // ============================
              // MASKOT ANIMATED
              // ============================
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: child,
                  );
                },
                child: SizedBox(
                  height: 220,
                  child: Image.asset(
                    "assets/images/bahagia.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ============================
              // TEKS INTRO
              // ============================
              FadeTransition(
                opacity: _fadeIn,
                child: Column(
                  children: const [
                    Text(
                      "Apakah kamu siap?",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Arci menunggumu untuk memulai\n"
                      "petualangan menjaga gula darah!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // ============================
              // TOMBOL MULAI
              // ============================
              FadeTransition(
                opacity: _fadeIn,
                child: ElevatedButton(
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
                      MaterialPageRoute(builder: (_) => const IntroPage1()),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
