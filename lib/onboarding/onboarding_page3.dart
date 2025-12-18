import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/bahagia.png", height: 220),

          const SizedBox(height: 20),

          const Text(
            "Ayo Mulai Perjalanan Sehatmu!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            "Kelola diabetes dengan lebih menyenangkan dan penuh pengetahuan. Yuk mulai sekarang!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.4),
          ),
        ],
      ),
    );
  }
}
