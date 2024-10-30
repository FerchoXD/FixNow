import 'package:flutter/material.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  _SelectServiceScreenState createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  final List<String> services = [
    'Plomería',
    'Electricidad',
    'Carpintería',
    'Pintura',
    'Limpieza general',
    'Jardinería',
    'Albañilería',
    'Fontanería',
    'Cerrajería',
    'Rep. de electrodomésticos',
    'Mant. de aires acondicionados',
    'Rep. de techo y filtraciones',
  ];

  final Set<String> selectedServices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Categoría de servicios',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Selecciona las áreas en donde te especializas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 20),
              // Barra de progreso (perfil general)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.10, // Cambia el valor según el progreso del perfil
                      backgroundColor: Color.fromARGB(255, 124, 204, 250),
                      color: Color.fromARGB(255, 23, 109, 201),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("10%", style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
              // Contador de selecciones
              Text(
                "Seleccionados: ${selectedServices.length}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Display service tags
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: services.map((service) => _buildServiceTag(service)).toList(),
              ),
              const SizedBox(height: 20),
              // "Continuar" button
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
                onPressed: selectedServices.length >= 1 && selectedServices.length <= 3
                    ? () {
                        // Aquí puedes manejar la acción del botón
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Continuando...')),
                        );
                      }
                    : null, // Desactiva el botón si no se cumple el rango de selección
                child: const Text('Continuar'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTag(String title) {
    final isSelected = selectedServices.contains(title);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedServices.remove(title);
          } else if (selectedServices.length < 3) {
            selectedServices.add(title);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                maxLines: 2, // Allow text to wrap to a second line if needed
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.check,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
