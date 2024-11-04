import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  final double scaleFactor;

  const Instructions({
    super.key,
    required this.scaleFactor,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.0 * scaleFactor),
      child: Text(
        'Personaliza tu perfil para destacar tus habilidades y atraer más clientes. Completa unos sencillos pasos para comenzar a ofrecer tus servicios y conectar con nuevos clientes.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color.fromARGB(255, 114, 114, 114),
          fontSize: 16 * scaleFactor,
        ),
      ),
    );
  }
}
