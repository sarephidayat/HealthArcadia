import 'package:flutter/material.dart';
import 'intro_page2.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1>
    with TickerProviderStateMixin {

  // Maskot Scaling + Fade animation
  late AnimationController _maskotController;
  late Animation<double> _maskotScale;
  late Animation<double> _maskotOpacity;

  // Typewriter text
  late AnimationController _textController;
  String displayedText = "";
  int textIndex = 0;

  final String fullText =
      "Halo! Aku Arci!\n"
      "Aku akan menemanimu dalam petualangan menjaga keseimbangan gula darah.\n\n"
      "Kita akan menghadapi tantangan, memilih makanan terbaik,\n"
      "dan mengambil keputusan penting seperti seorang pahlawan sejati!\n\n"
      "Bersamamu… aku yakin kita bisa mencapai keseimbangan sempurna!";

  @override
  void initState() {
    super.initState();

    // === MASKOT ANIMATION ===
    _maskotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _maskotScale = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _maskotController, curve: Curves.easeOutBack),
    );

    _maskotOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _maskotController, curve: Curves.easeIn),
    );

    _maskotController.forward();

    // === TYPEWRITER ANIMATION ===
    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: fullText.length * 22),
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
    _maskotController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),

        child: Column(
          children: [

            const SizedBox(height: 20),

            // ============================
            // MASKOT BESAR (FADE + ZOOM)
            // ============================
            AnimatedBuilder(
              animation: _maskotController,
              builder: (context, child) {
                return Opacity(
                  opacity: _maskotOpacity.value,
                  child: Transform.scale(
                    scale: _maskotScale.value,
                    child: child,
                  ),
                );
              },
              child: SizedBox(
                height: 250,
                child: Image.asset("assets/images/maskot.png"),
              ),
            ),

            const SizedBox(height: 20),

            // Subtitle kecil
            AnimatedOpacity(
              opacity: textIndex > 10 ? 1 : 0,
              duration: const Duration(milliseconds: 800),
              child: Text(
                "Petualangan Dimulai…",
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ============================
            // TYPEWRITER TEXT
            // ============================
            Expanded(
              child: AnimatedOpacity(
                opacity: textIndex > 5 ? 1 : 0,
                duration: const Duration(milliseconds: 600),
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
            // NEXT BUTTON
            // ============================
            AnimatedOpacity(
              opacity: (textIndex == fullText.length) ? 1 : 0,
              duration: const Duration(milliseconds: 800),

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const IntroPage2()));
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

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
