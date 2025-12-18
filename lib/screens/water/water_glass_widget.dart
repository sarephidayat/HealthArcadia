import 'package:flutter/material.dart';
import 'water_constants.dart';

class WaterGlassWidget extends StatelessWidget {
  final int currentMl;

  const WaterGlassWidget({super.key, required this.currentMl});

  @override
  Widget build(BuildContext context) {
    double fillPercent = currentMl / WaterConstants.dailyGoal;
    fillPercent = fillPercent.clamp(0.0, 1.0);

    return SizedBox(
      width: 140,
      height: 240,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // AIR
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: 110,
            height: 220 * fillPercent,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.6),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
          ),

          // OUTLINE GELAS
          Image.asset(
            "assets/images/glass_outline.png",
            width: 140,
            height: 240,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
