import 'package:flutter/material.dart';

class StartButton extends StatefulWidget {
  final double scaleFactor;

  const StartButton({
    super.key,
    required this.scaleFactor,
    });

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  @override
  Widget build(BuildContext context) {
    final scaleFactor = widget.scaleFactor;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 76, 152, 233),
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 20 * scaleFactor,
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor, vertical: 15 * scaleFactor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * scaleFactor),
        ),
        elevation: 5 * scaleFactor,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/basic_information');
      },
      child: const Text('Comenzar'),
    );
  }
}
