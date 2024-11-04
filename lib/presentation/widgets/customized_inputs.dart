import 'package:flutter/material.dart';

class CustomizedInputs extends StatelessWidget {
  final double scaleFactor;
  final String label;
  final double fontSize;
  final bool obscureText;

  const CustomizedInputs({
    super.key,
    this.fontSize = 14.0, 
    required this.scaleFactor, 
    required this.label, 
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: const Color(0xFF4C98E9),
      style: TextStyle(
        fontSize: fontSize * scaleFactor,
        fontWeight: obscureText ? FontWeight.normal : FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.5 * scaleFactor)),
        ),
        hintStyle: TextStyle(
          color: const Color.fromARGB(113, 48, 48, 48),
          fontSize: 14 * scaleFactor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(113, 48, 48, 48)),
          borderRadius: BorderRadius.all(Radius.circular(15.5 * scaleFactor)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 76, 152, 233)),
          borderRadius: BorderRadius.all(Radius.circular(15.5 * scaleFactor)),
        ),
      ),
    );
  }
}
