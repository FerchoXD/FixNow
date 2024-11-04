import 'package:flutter/material.dart';

class RegisterFooterButton extends StatelessWidget {
  final double scaleFactor;

  const RegisterFooterButton({
    super.key, 
    required this.scaleFactor
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed('/'),
      child: Text(
        'Volver al inicio',
        style: TextStyle(
          fontSize: 14 * scaleFactor,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 81, 113, 218),
        ),
      ),
    );
  }
}
