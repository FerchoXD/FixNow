import 'package:flutter/material.dart';

class SpecialityHeader extends StatelessWidget {
  final double scaleFactor;

  const SpecialityHeader({
    super.key,
    required this.scaleFactor,
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      '¡Bienvenido Fernando!',
      style: TextStyle(
        color: const Color(0xFF4C98E9),
        fontSize: 24 * scaleFactor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
