import 'package:fixnow/presentation/widgets/configure_supplier_profile/select_service/select_service_build_service_tag.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/select_service/select_service_continue_button.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.10, // Cambia el valor según el progreso del perfil
                      backgroundColor: const Color.fromARGB(255, 124, 204, 250),
                      color: const Color.fromARGB(255, 23, 109, 201),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("10%", style: TextStyle(fontSize: 14)),
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
                children: services.map((service) => 
                  BuildServiceTag(
                    service,
                    isSelected: selectedServices.contains(service),
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedServices.remove(service);
                        } else if (selectedServices.length < 3) {
                          selectedServices.add(service);
                        }
                      });
                    },
                  )
                ).toList(),
              ),
              const SizedBox(height: 20),
              // "Continuar" button
              SelectServiceContinueButton(selectedServices: selectedServices), 
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
