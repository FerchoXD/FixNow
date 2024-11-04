import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BasicInformationScreen extends StatelessWidget {
  const BasicInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Información básica',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Completa los campos para que los clientes puedan conocerte y contactarte fácilmente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Barra de progreso con color celeste
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.0, // Cambia el valor según el progreso
                      backgroundColor: Color.fromARGB(255, 124, 204, 250),
                      color: Color.fromARGB(255, 23, 109, 201), // Color celeste
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("0%", style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
              // Campos de texto
              const TextField(
                cursorColor: Color(0xFF4C98E9),
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
              const SizedBox(height: 10),
              const TextField(
                cursorColor: Color(0xFF4C98E9),
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
              const SizedBox(height: 10),
              const TextField(
                cursorColor: Color(0xFF4C98E9),
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
              const SizedBox(height: 10),
              const IntlPhoneField(
              cursorColor: Color(0xFF4C98E9),
              initialCountryCode: 'MX',
              decoration: InputDecoration(
                hintText: 'Teléfono',
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
                counterText: '', // Elimina el contador de caracteres
              ),
              invalidNumberMessage: 'Número de teléfono no válido', // Mensaje de error personalizado
              searchText: 'Busca tu pais', // Texto para buscar país
              dropdownTextStyle: TextStyle(color: Colors.black), // Estilo de texto en el menú
            ),
              const SizedBox(height: 10),
              const TextField(
                cursorColor: Color(0xFF4C98E9),
                  decoration: InputDecoration(
                    hintText: 'Ubicacion',
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
              // Botón de continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/select_service');
                  },
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

