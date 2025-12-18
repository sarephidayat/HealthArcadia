import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

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
            "Pantau Kesehatanmu Setiap Hari",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            "Mulai dari edukasi diabetes, permainan interaktif, artikel kesehatan, hingga pengingat minum air — semuanya tersedia dalam satu aplikasi.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.4),
          )
        ],
      ),
    );
  }
}
