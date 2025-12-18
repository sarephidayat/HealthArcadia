import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

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
            "Selamat Datang di HealthArcadia!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            "Aplikasi pendamping harian untuk membantu mengelola Diabetes Tipe 1 dengan lebih mudah, aman, dan terarah.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.4),
          ),
        ],
      ),
    );
  }
}
