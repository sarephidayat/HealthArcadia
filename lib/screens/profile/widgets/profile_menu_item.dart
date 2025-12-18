import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: Colors.red),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
