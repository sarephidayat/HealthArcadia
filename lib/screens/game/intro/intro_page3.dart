import 'package:flutter/material.dart';
import 'intro_page4.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3>
    with TickerProviderStateMixin {

  // TYPEWRITER narasi
  late AnimationController _textController;
  String displayedText = "";
  int textIndex = 0;

  // Flash red alert
  late AnimationController _flashController;

  // Shaking animation (intensitas kecil)
  late AnimationController _shakeController;
  late Animation<double> _shakeAnim;

  // Blood bar animation
  late AnimationController _bloodController;
  late Animation<double> _bloodAnim;

  final String fullText =
      "Tubuh Arci semakin melemah...\n\n"
      "Gula darahnya turun drastis dan membuatnya kehilangan tenaga.\n"
      "Setiap langkah terasa berat, dan pandangannya mulai kabur.\n\n"
      "Namun… Arci tidak menyerah.\n"
      "Ia percaya bahwa kamu datang untuk menolongnya.\n\n"
      "Ayo bantu Arci memulihkan kekuatan dan menstabilkan gula darahnya!";

  @override
  void initState() {
    super.initState();

    // TYPEWRITER
    _textController = AnimationController(
      duration: Duration(milliseconds: fullText.length * 25),
      vsync: this,
    );

    _textController.addListener(() {
      setState(() {
        textIndex = (_textController.value * fullText.length).floor();
        displayedText = fullText.substring(0, textIndex);
      });
    });

    _textController.forward();

    // FLASH EFFECT
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // SHAKE (halus)
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _shakeAnim = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );

    // BLOOD METER
    _bloodController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _bloodAnim = Tween<double>(begin: 1.0, end: 0.25).animate(
      CurvedAnimation(parent: _bloodController, curve: Curves.easeInOut),
    );

    _bloodController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _flashController.dispose();
    _shakeController.dispose();
    _bloodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flashController,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,

          body: Stack(
            children: [
              // ============================
              // BACKGROUND FLASH RED WARNING
              // ============================
              Opacity(
                opacity: 0.25 + _flashController.value * 0.25,
                child: Container(color: Colors.red.shade50),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),

                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // ============================
                    // BLOOD LEVEL METER
                    // ============================
                    Column(
                      children: [
                        Text(
                          "Kadar Gula Darah",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),

                        AnimatedBuilder(
                          animation: _bloodController,
                          builder: (_, __) {
                            return Container(
                              height: 16,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      _bloodAnim.value,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ============================
                    // MASKOT WEAK ANIMATION
                    // ============================
                    AnimatedBuilder(
                      animation: _shakeController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_shakeAnim.value, 0),
                          child: child,
                        );
                      },
                      child: SizedBox(
                        height: 230,
                        child: Image.asset("assets/images/lesu.png"),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ============================
                    // TEXT NARATION (TYPEWRITER)
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

                    const SizedBox(height: 16),

                    // ============================
                    // BUTTON NEXT
                    // ============================
                    AnimatedOpacity(
                      opacity: (textIndex == fullText.length) ? 1 : 0,
                      duration: const Duration(milliseconds: 800),

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const IntroPage4()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 42,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Aku akan menolongmu, Arci ➜",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
