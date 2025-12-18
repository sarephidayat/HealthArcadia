import 'package:flutter/material.dart';
import 'water_controller.dart';
import 'water_constants.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  final WaterController controller = WaterController();

  @override
  void initState() {
    super.initState();
    controller.loadWater().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (controller.currentMl / WaterConstants.dailyGoalMl)
        .clamp(0, 1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Water Tracker"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 10),

            // ⭐ MASKOT ARCI
            SizedBox(
              height: 160,
              child: Image.asset(
                "assets/images/bahagia.png",
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 10),

            // ⭐ Motivasi
            const Text(
              "Ayo Minum Air Putih!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Target harian: 2000 ml",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            // ⭐ Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.currentMl} / 2000 ml",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: progress < 0.5
                            ? Colors.blue
                            : progress < 1.0
                                ? Colors.lightBlueAccent
                                : Colors.green,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 40),

            // ⭐ Tombol tambah air minum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                waterButton("+100 ml", 100),
                waterButton("+250 ml", 250),
                waterButton("+500 ml", 500),
              ],
            ),

            const SizedBox(height: 40),

            // Reset button
            TextButton(
              onPressed: () {
                controller.resetWater();
                setState(() {});
              },
              child: const Text(
                "Reset Hari Ini",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget waterButton(String title, int ml) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        controller.addWater(ml);
        setState(() {});
      },
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
