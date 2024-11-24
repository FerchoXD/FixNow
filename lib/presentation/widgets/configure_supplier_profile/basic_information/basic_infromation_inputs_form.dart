import 'package:fixnow/presentation/widgets/customized_inputs.dart';
import 'package:flutter/material.dart';

class BasicInformationInputsForm extends StatefulWidget {
  final double scaleFactor; // Declara el scaleFactor como parámetro

  const BasicInformationInputsForm({super.key, required this.scaleFactor});

  @override
  State<BasicInformationInputsForm> createState() => _BasicInformationInputsFormState();
}

class _BasicInformationInputsFormState extends State<BasicInformationInputsForm> {
  @override
  Widget build(BuildContext context) {
    final scaleFactor = widget.scaleFactor; 

    return Column(
      children: [
        CustomizedInputs( scaleFactor: scaleFactor, label: 'Nombres'),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs( scaleFactor: scaleFactor, label: 'Apellidos'),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs( scaleFactor: scaleFactor, label: 'Correo electrónico'),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs( scaleFactor: scaleFactor, label: 'Contraseña', obscureText: true),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs( scaleFactor: scaleFactor, label: 'Ubicación',),
      ],
    );
  }
}

      /* IntlPhoneField(
  cursorColor: const Color(0xFF4C98E9),
  initialCountryCode: 'MX',
  decoration: InputDecoration(
    hintText: 'Teléfono',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.5 * scaleFactor)),
    ),
    hintStyle: TextStyle(
      color: const Color.fromARGB(113, 48, 48, 48),
      fontSize: 14 * scaleFactor,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(113, 48, 48, 48),
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.5 * scaleFactor)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFF4C98E9),
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.5 * scaleFactor)),
    ),
    counterText: '', // Elimina el contador de caracteres
  ),
  invalidNumberMessage: 'Número de teléfono no válido', // Mensaje de error personalizado
  searchText: 'Busca tu país', // Texto para buscar país
  dropdownTextStyle: TextStyle(
    color: Colors.black,
    fontSize: 14 * scaleFactor, // Ajusta el tamaño de texto con scaleFactor
  ),
  dropdownIconPosition: IconPosition.trailing, // Configura la posición del icono si es necesario
  dropdownIcon: Icon(Icons.arrow_drop_down, size: 24 * scaleFactor), // Ajusta el tamaño del icono
),*/