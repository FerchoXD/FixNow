import 'package:flutter/material.dart';

class LoginButtonForm extends StatefulWidget {
  final double scaleFactor;
  const LoginButtonForm({
    super.key,
    required this.scaleFactor,
    });

  @override
  State<LoginButtonForm> createState() => _LoginButtonFormState();
}

class _LoginButtonFormState extends State<LoginButtonForm> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C98E9),
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 20 * widget.scaleFactor,
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 30 * widget.scaleFactor,
            vertical: 15 * widget.scaleFactor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * widget.scaleFactor),
        ),
        elevation: 5,
      ),
      onPressed: () => {Navigator.pushReplacementNamed(context, '/')}, 
      child: const Text('Iniciar sesión'),
    
    );
  }
}
