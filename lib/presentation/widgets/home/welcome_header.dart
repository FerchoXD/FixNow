import 'package:flutter/material.dart';
import 'package:fixnow/core/themes/custom_text_styles.dart';

class WelcomeHeader extends StatelessWidget {
  final double scaleFactor;
  const WelcomeHeader({super.key, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'FixNow',
          style: textTheme.tituloBlanco42(scaleFactor),
        ),
        SizedBox(height: 10 * scaleFactor),
        Text(
          'Tu aliado inteligente para el cuidado del hogar.',
          textAlign: TextAlign.center,
          style: textTheme.textoBlanco16(scaleFactor),
        ),
      ],
    );
  }
}
