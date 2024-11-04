import 'package:flutter/material.dart';

class RegisterButtonForm extends StatelessWidget {
  final String tipoUsuario;
  final double scaleFactor;

  const RegisterButtonForm({
    required this.tipoUsuario,
    required this.scaleFactor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C98E9),
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 14 * scaleFactor, // Tamaño de texto adaptado
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 30 * scaleFactor, // Padding horizontal adaptado
          vertical: 15 * scaleFactor,   // Padding vertical adaptado
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * scaleFactor), // Border radius adaptado
        ),
        elevation: 5 * scaleFactor, // Elevación adaptada
      ),
      onPressed: () {
        tipoUsuario == 'cliente'
            ? Navigator.pushNamed(context, '/chat')
            : Navigator.pushReplacementNamed(context, '/specialities');
      },
      child: const Text('Registrarse'),
    );
  }
}
