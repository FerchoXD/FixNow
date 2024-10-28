import 'package:flutter/material.dart';

class Screen404 extends StatefulWidget {
  const Screen404({super.key});

  @override
  State<Screen404> createState() => _Screen404State();
}

class _Screen404State extends State<Screen404> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4C98E9),
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '¡Upps!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4C98E9),
                fontSize: 36,
              ),
            ),
            Text(
              'Algo salió mal.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 114, 114, 114),
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 40), // Espacio entre el texto y el botón
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C98E9), // Color de fondo azul
                foregroundColor: Colors.white, // Texto en blanco
                side: const BorderSide(color: Color(0xFF4C98E9)), // Borde azul
                padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Regresar a la última página
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

