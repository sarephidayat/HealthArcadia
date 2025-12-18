import 'package:flutter/material.dart';
import '../gameplay/gameplay_screen.dart';

class IntroPage4 extends StatefulWidget {
  const IntroPage4({super.key});

  @override
  State<IntroPage4> createState() => _IntroPage4State();
}

class _IntroPage4State extends State<IntroPage4>
    with TickerProviderStateMixin {
      
  // Aura glow animation
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  // Typewriter text
  late AnimationController _textController;
  String displayedText = "";
  int textIndex = 0;

  final String fullText =
      "Berkat bantuanmu...\n\n"
      "Arci mulai merasakan kekuatannya kembali.\n"
      "Tubuhnya mulai hangat, dan kadar gula darahnya perlahan stabil.\n\n"
      "Arci menatapmu dengan penuh harapan.\n"
      "Ia tahu, perjalanan baru saja dimulai.\n\n"
      "Sekarang… petualangan kalian berdua akan dimulai.\n"
      "Saatnya menjaga gula darah Arci tetap stabil dan menghadapi tantangan!";

  @override
  void initState() {
    super.initState();

    // GLOW ANIMATION
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnim = Tween<double>(begin: 0.85, end: 1.12).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // TYPEWRITER
    _textController = AnimationController(
      duration: Duration(milliseconds: fullText.length * 25),
      vsync: this,
    );

    _textController.addListener(() {
      setState(() {
        final count = (_textController.value * fullText.length).floor();
        displayedText = fullText.substring(0, count);
      });
    });

    _textController.forward();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (_, __) {
        return Scaffold(
          backgroundColor: Colors.white,

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // ✨ ARCI RECOVER WITH GLOW
                Center(
                  child: Transform.scale(
                    scale: _glowAnim.value,
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withOpacity(0.10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 35,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          "assets/images/bahagia.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 📜 TYPEWRITER TEXT
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      displayedText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ⭐ NEXT: START GAMEPLAY
                AnimatedOpacity(
                  opacity: displayedText.length == fullText.length ? 1 : 0,
                  duration: const Duration(milliseconds: 800),

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GameplayScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Mulai Game! 🚀",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
