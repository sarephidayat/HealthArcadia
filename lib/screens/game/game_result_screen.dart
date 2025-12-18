import 'package:flutter/material.dart';
import 'package:healtharcadia/screens/game/game_play_screen.dart';

class GameResultScreen extends StatelessWidget {
  const GameResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/bahagia.png",
                height: 160,
              ),
              const SizedBox(height: 20),

              const Text(
                "Kerja Bagus! 🎉",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Kamu berhasil menjaga gula darah tetap stabil.\n"
                "Teruskan kebiasaan sehatmu setiap hari!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GamePlayScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Main Lagi",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.pop(context); // kembali ke intro / game_screen
                },
                child: const Text(
                  "Kembali",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
