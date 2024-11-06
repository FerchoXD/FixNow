import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center( // Centrar toda la columna
        child: SingleChildScrollView( // Scroll para evitar overflow con teclado
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity, // Para ocupar todo el ancho disponible
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bienvenido',
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
                    'Por favor ingresa tus datos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 114, 114, 114),
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
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
                    context.push('/home');
                  },
                  child: const Text('Inicio de sesión'),
                ),
                const SizedBox(height: 60),
                const Text(
                  'O conéctate con',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botón de Google
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
                    const SizedBox(width: 40),
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
                const SizedBox(height: 90),
                TextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  child: const Text(
                    '¿No tienes cuenta? Regístrate',
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
