import 'package:flutter/material.dart';
import 'game_intro_screen.dart';

class OpeningAnimationScreen extends StatefulWidget {
  const OpeningAnimationScreen({super.key});

  @override
  State<OpeningAnimationScreen> createState() => _OpeningAnimationScreenState();
}

class _OpeningAnimationScreenState extends State<OpeningAnimationScreen>
    with TickerProviderStateMixin {

  late AnimationController logoController;
  late AnimationController maskotController;
  late AnimationController loadingController;

  late Animation<double> logoOpacity;
  late Animation<double> maskotOpacity;

  @override
  void initState() {
    super.initState();

    // LOGO FADE-IN ANIMATION
    logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeIn),
    );

    // MASKOT APPEAR LATE
    maskotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    maskotOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: maskotController, curve: Curves.easeInOut),
    );

    // LOADING DOTS
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // JALANKAN ANIMASI BERTAHAP
    Future.delayed(const Duration(milliseconds: 400), () => logoController.forward());
    Future.delayed(const Duration(milliseconds: 1500), () => maskotController.forward());

    // Setelah 3.5 detik → masuk intro pertama
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const GameIntroScreen()),
      );
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    maskotController.dispose();
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // LOGO FADE-IN
            FadeTransition(
              opacity: logoOpacity,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "HealthArcadia",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            

            // LOADING DOTS
            AnimatedBuilder(
              animation: loadingController,
              builder: (context, child) {
                double value = loadingController.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loadingDot(value > 0.25),
                    const SizedBox(width: 6),
                    loadingDot(value > 0.5),
                    const SizedBox(width: 6),
                    loadingDot(value > 0.75),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: active ? Colors.red : Colors.red.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}
