import 'package:flutter/material.dart';

class BasicInformationContinueButton extends StatefulWidget {
  final double scaleFactor;
  const BasicInformationContinueButton({
    super.key, 
    required this.scaleFactor
    });

  @override
  State<BasicInformationContinueButton> createState() => _BasicInformationContinueButtonState();
}

class _BasicInformationContinueButtonState extends State<BasicInformationContinueButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 15 * widget.scaleFactor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10 * widget.scaleFactor),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/select_service');
        },
        child: Text(
          'Continuar',
          style: TextStyle(
            fontSize: 18 * widget.scaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
