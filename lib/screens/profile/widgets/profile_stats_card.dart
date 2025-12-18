import 'package:flutter/material.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          statItem("Air Hari Ini", "1200 ml"),
          statItem("Skor Game", "850 XP"),
          statItem("Artikel Dibaca", "12"),
        ],
      ),
    );
  }

  Widget statItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
