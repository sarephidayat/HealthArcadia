import 'package:flutter/material.dart';

class BloodMeter extends StatelessWidget {
  final int level;          // 0–100
  final String statusText;  // "Stabil", dll.
  final int statusType;     // 0 low,1 normal,2 high

  const BloodMeter({
    super.key,
    required this.level,
    required this.statusText,
    required this.statusType,
  });

  Color get barColor {
    if (statusType == 0) return Colors.blueAccent;
    if (statusType == 2) return Colors.redAccent;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Kadar Gula Arci",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // bar
        Container(
          height: 18,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: level / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),
        Text(
          "$statusText • $level%",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
