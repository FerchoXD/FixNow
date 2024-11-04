import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final double scaleFactor;

  const SkipButton({
    super.key,
    required this.scaleFactor,
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/home');
      },
      child: Text(
        'Hacerlo más tarde',
        style: TextStyle(
          color: const Color(0xFF5D9FE6),
          fontSize: 16 * scaleFactor,
        ),
      ),
    );
  }
}
