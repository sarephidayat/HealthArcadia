import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../onboarding/onboarding_screen.dart';
import '../auth/auth_check.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    );

    _startAppFlow();
  }

  Future<void> _startAppFlow() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool("seen_onboarding") ?? false;

    if (!seen) {
      // ➜ Belum lihat onboarding → ke Onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } else {
      // ➜ Sudah lihat onboarding → cek login via AuthCheck
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthCheck()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnim,
              child: Image.asset(
                "assets/images/logo.png",
                height: 180,
              ),
            ),

            const SizedBox(height: 20),

            FadeTransition(
              opacity: _fadeAnim,
              child: const Text(
                "HealthArcadia",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),

            FadeTransition(
              opacity: _fadeAnim,
              child: const Text(
                "Solusi harian untuk pengelolaan Diabetes Tipe 1",
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
