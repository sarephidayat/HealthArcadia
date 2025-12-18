import 'package:flutter/material.dart';
import 'intro_page3.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2>
    with TickerProviderStateMixin {

  // Maskot shake animation
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  // Warning pulse animation
  late AnimationController _warningController;
  late Animation<double> _warningScale;
  late Animation<Color?> _warningColor;

  // Typewriter text
  late AnimationController _textController;
  String displayedText = "";
  int textIndex = 0;

  final String fullText =
      "Oh tidak!\n"
      "Arci mulai merasakan ketidakstabilan pada kadar gula darahnya...\n\n"
      "Kadang naik… kadang turun… tubuh Arci mulai bingung!\n\n"
      "Jika tidak ada yang membantu, kadar gula darah Arci bisa menjadi berbahaya.\n\n"
      "Kamu satu-satunya yang bisa menolongnya sekarang!";

  @override
  void initState() {
    super.initState();

    // MASKOT SHAKE
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _shakeAnimation = Tween<double>(begin: -3, end: 3).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );

    // WARNING PULSE
    _warningController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _warningScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _warningController, curve: Curves.easeInOut),
    );

    _warningColor = ColorTween(
      begin: Colors.red.shade600,
      end: Colors.red.shade300,
    ).animate(_warningController);

    // TYPEWRITER
    _textController = AnimationController(
      duration: Duration(milliseconds: fullText.length * 22),
      vsync: this,
    );

    _textController.addListener(() {
      setState(() {
        textIndex = (_textController.value * fullText.length).floor();
        displayedText = fullText.substring(0, textIndex);
      });
    });

    _textController.forward();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _warningController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6E6),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ============================
            // ⚠️ WARNING WITH PULSE ANIMATION
            // ============================
            AnimatedBuilder(
              animation: _warningController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _warningScale.value,
                  child: Column(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: _warningColor.value, size: 50),
                      const SizedBox(height: 6),
                      Text(
                        "Gula Darah Tidak Stabil!",
                        style: TextStyle(
                          color: _warningColor.value,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // ============================
            // 😰 MASKOT SHAKE ONLY
            // ============================
            AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_shakeAnimation.value, 0),
                  child: child,
                );
              },
              child: SizedBox(
                height: 200,
                child: Image.asset("assets/images/badmood.png"),
              ),
            ),

            const SizedBox(height: 20),

            // ============================
            // TYPEWRITER NARRATION
            // ============================
            Expanded(
              child: AnimatedOpacity(
                opacity: textIndex > 5 ? 1 : 0,
                duration: const Duration(milliseconds: 400),
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
            ),

            const SizedBox(height: 20),

            // ============================
            // BUTTON NEXT
            // ============================
            AnimatedOpacity(
              opacity: (textIndex == fullText.length) ? 1 : 0,
              duration: const Duration(milliseconds: 800),

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const IntroPage3()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Lanjutkan ➜",
                  style: TextStyle(
                    fontSize: 18,
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
  }
}
