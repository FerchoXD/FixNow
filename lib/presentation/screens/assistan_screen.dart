import 'package:flutter/material.dart';

class AssistantScreen extends StatelessWidget {
  final String username = "Alan"; // Nombre del usuario

  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.assistant,
              color: colors.primary,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Buen día, $username',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '¿Cuál es tu problema?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Escribe aquí...',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colors.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.5)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(113, 48, 48, 48),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.5)),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para enviar mensaje al asistente
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      backgroundColor: colors.primary,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
