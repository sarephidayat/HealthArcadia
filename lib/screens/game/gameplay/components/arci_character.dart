import 'package:flutter/material.dart';

class ArciCharacter extends StatelessWidget {
  /// 0 = low, 1 = normal, 2 = high
  final int statusType;

  const ArciCharacter({super.key, required this.statusType});

  String get assetPath {
    switch (statusType) {
      case 0:
        return "assets/images/lesu.png";
      case 2:
        return "assets/images/marah.png";
      default:
        return "assets/images/bahagia.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Image.asset(assetPath),
    );
  }
}
