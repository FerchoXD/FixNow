import 'package:flutter/material.dart';

class RegisterActions extends StatelessWidget {
  final double scaleFactor;

  const RegisterActions({
    super.key, 
    required this.scaleFactor 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'O conéctate con', 
          style: TextStyle(color: Colors.black, fontSize: 16 * scaleFactor),
        ),
        SizedBox(height: 20 * scaleFactor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              imagePath: 'assets/images/google.png', 
              label: 'Google',
              scaleFactor: scaleFactor,
            ),
            SizedBox(width: 20 * scaleFactor),
            SocialButton(
              imagePath: 'assets/images/facebook.png', 
              label: 'Facebook',
              scaleFactor: scaleFactor,
            ),
          ],
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final double scaleFactor; // Agrega scaleFactor

  const SocialButton({
    required this.imagePath, 
    required this.label, 
    required this.scaleFactor, // Asegúrate de recibir scaleFactor
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10 * scaleFactor), // Ajusta el tamaño del borde
      ),
      padding: EdgeInsets.symmetric(horizontal: 10 * scaleFactor, vertical: 8 * scaleFactor), // Ajusta el padding
      child: Row(
        children: [
          Image.asset(imagePath, width: 30 * scaleFactor, height: 30 * scaleFactor), // Ajusta el tamaño de la imagen
          SizedBox(width: 10 * scaleFactor), // Ajusta el espacio entre la imagen y el texto
          Text(
            label, 
            style: TextStyle(fontSize: 16 * scaleFactor), // Ajusta el tamaño del texto
          ),
        ],
      ),
    );
  }
}
