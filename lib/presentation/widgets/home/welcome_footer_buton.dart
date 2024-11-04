import 'package:flutter/material.dart';

class WelcomeFooterButon extends StatelessWidget {
  final double scaleFactor;

  const WelcomeFooterButon({
    super.key, 
    required this.scaleFactor,
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {Navigator.pushReplacementNamed(context, '/login')},
      child: Text(
          '¿Ya tienes cuenta? Inicia sesión',
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.underline,
          fontSize: 14 * scaleFactor,
        ),
      ),
    );
  }
}
