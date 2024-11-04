
import 'package:fixnow/core/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final double scaleFactor;
  const LoginHeader({super.key, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Bienvenido',
            style: textTheme.tituloAzul32(scaleFactor),
          ),
        ),
        SizedBox(height: 10 * scaleFactor),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Por favor ingresa tus datos.',
            style: textTheme.textoNegro14(scaleFactor),
          ),
        ),
      ],
    );
  }
}