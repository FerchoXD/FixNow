import 'package:flutter/material.dart';

class BasicInformationTitle extends StatelessWidget {
  final double scaleFactor;
  
  const BasicInformationTitle({
    super.key,
    required this.scaleFactor,
    });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Información básica',
        style: TextStyle(
          fontSize: 24 * scaleFactor,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}
