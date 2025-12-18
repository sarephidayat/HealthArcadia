import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        CircleAvatar(
          radius: 45,
          backgroundImage: AssetImage("assets/images/maskot.png"),
        ),

        const SizedBox(height: 10),

        // Name
        const Text(
          "Syarifudin",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          "pengguna@healtharcadia.com",
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),

        const SizedBox(height: 12),

        // Edit Button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
