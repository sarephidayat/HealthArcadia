import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';
import 'onboarding_page1.dart';
import 'onboarding_page2.dart';
import 'onboarding_page3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int index = 0;

  Future<void> finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seen_onboarding", true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (i) => setState(() => index = i),
            children: const [
              OnboardingPage1(),
              OnboardingPage2(),
              OnboardingPage3(),
            ],
          ),

          Positioned(
            bottom: 40,
            right: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
              ),
              child: Text(index == 2 ? "Mulai" : "Lanjut"),
              onPressed: () {
                if (index == 2) {
                  finish();
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
