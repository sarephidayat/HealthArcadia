import 'package:flutter/material.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/profile_stats_card.dart';
import 'package:healtharcadia/auth/auth_service.dart';
import 'package:healtharcadia/auth/login_screen.dart';
import 'faq_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const ProfileHeader(),

            const SizedBox(height: 20),

            // Stats Card (Water intake, XP, Game Score)
            const ProfileStatsCard(),

            const SizedBox(height: 30),

            // =======================
            // MENU LIST
            // =======================
            ProfileMenuItem(
              icon: Icons.settings,
              title: "Pengaturan",
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: "Kebijakan Privasi",
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.info_outline,
              title: "Tentang Aplikasi",
              onTap: () {},
            ),

            // FAQ MENU
            ProfileMenuItem(
              icon: Icons.help_outline,
              title: "FAQ",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FaqScreen()),
                );
              },
            ),

            const SizedBox(height: 10),

            // LOGOUT BUTTON
            TextButton(
              onPressed: () async {
                await AuthService.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
