import 'package:flutter/material.dart';

class SelectServiceContinueButton extends StatelessWidget {
  final Set<String> selectedServices;

  const SelectServiceContinueButton({
    super.key,
    required this.selectedServices,
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 76, 152, 233),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
      onPressed: selectedServices.length >= 1 && selectedServices.length <= 3
          ? () {
              Navigator.pushNamed(context, '/work_experience');
            }
          : null, // Desactiva el botón si no se cumple el rango de selección
      child: const Text('Continuar'),
    );
  }
}
