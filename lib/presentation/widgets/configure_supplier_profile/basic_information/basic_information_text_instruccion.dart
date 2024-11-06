import 'package:flutter/material.dart';

class BasicInformationTextInstruccion extends StatelessWidget {
  final double scaleFactor;

  const BasicInformationTextInstruccion({
    super.key,
    required this.scaleFactor,
    });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Completa los campos para que los clientes puedan conocerte y contactarte fácilmente.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16 * scaleFactor,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
