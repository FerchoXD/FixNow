import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView( // Hace scroll cuando el teclado está abierto
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimiza el tamaño vertical del contenido
              children: [
                const SizedBox(height: 80),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Únete',
                    style: TextStyle(
                      color: Color(0xFF4C98E9),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Regístrate para conectar con profesionales, u ofrece tus servicios de manera fácil.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 114, 114, 114),
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Nombre(s)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(113, 48, 48, 48),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(113, 48, 48, 48),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 76, 152, 233),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Apellidos',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(113, 48, 48, 48),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(113, 48, 48, 48),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 76, 152, 233),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(113, 48, 48, 48),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(113, 48, 48, 48),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 76, 152, 233),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(113, 48, 48, 48),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(113, 48, 48, 48),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 76, 152, 233),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.5)),
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
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
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Registrarse'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'O conéctate con',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Google',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/facebook.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Facebook',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text(
                    'Volver al inicio',
                    style: TextStyle(color: Color.fromARGB(255, 81, 113, 218)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
