import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  final double scaleFactor;
  const RegisterHeader({super.key,
    required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Únete',
          style: TextStyle(
            color: const Color(0xFF4C98E9),
            fontSize: 32 * scaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Regístrate para conectar con profesionales, u ofrece tus servicios de manera fácil.',
          style: TextStyle(
            color: const Color.fromARGB(255, 114, 114, 114),
            fontSize: 14 * scaleFactor,
          ),
        ),
      ],
    );
  }
}

