import 'package:flutter/material.dart';

class LoginFooterButton extends StatelessWidget {
  final double scaleFactor;

  const LoginFooterButton({
    super.key, 
    required this.scaleFactor,
    });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {Navigator.pushReplacementNamed(context, '/')},
      child: Text(
          '¿No tienes una cuenta? Regístrate',
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
          fontSize: 14 * scaleFactor,
        ),
      ),
    );
  }
}
