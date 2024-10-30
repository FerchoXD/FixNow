import 'package:flutter/material.dart';

class SpecialitiesScreen extends StatelessWidget {
  const SpecialitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenido Fernando!',
              style: TextStyle(
                color: Color(0xFF4C98E9),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Separación entre los textos
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Personaliza tu perfil para destacar tus habilidades y atraer más clientes. Completa unos sencillos pasos para comenzar a ofrecer tus servicios y conectar con nuevos clientes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 114, 114, 114),
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 40), // Separación antes del botón
            ElevatedButton(
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
              onPressed: () {
                // Acción al presionar el botón
              },
              child: const Text('Comenzar'),
            ),
            const SizedBox(height: 20),

            // Botón para omitir el proceso de personalización
            TextButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              child: const Text(
                'Hacerlo más tarde',
                style: TextStyle(
                  color: Color(0xFF5D9FE6),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
