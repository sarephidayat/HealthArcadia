import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FAQ",
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.red),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          FaqItem(
            question: "Apa itu HealthArcadia?",
            answer:
                "HealthArcadia adalah aplikasi edukasi diabetes tipe 1 dengan fitur game, artikel, chatbot, dan monitoring kesehatan.",
          ),
          FaqItem(
            question: "Apakah aplikasi ini gratis?",
            answer:
                "Ya! Semua fitur dapat digunakan secara gratis.",
          ),
          FaqItem(
            question: "Data saya aman?",
            answer:
                "Kami hanya menyimpan data dasar login. Aplikasi ini tidak mengakses data pribadi lainnya.",
          ),
          FaqItem(
            question: "Apakah ada fitur pengingat minum air?",
            answer:
                "Ya! Kamu dapat mengaktifkan pengingat minum air di menu Notifikasi.",
          ),
        ],
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            answer,
            style: const TextStyle(height: 1.4),
          ),
        )
      ],
    );
  }
}
