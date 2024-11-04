import 'package:fixnow/presentation/widgets/customized_inputs.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final double scaleFactor;
  
  const RegisterForm({
    super.key,
    required this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomizedInputs(
          label: 'Nombre(s)',
          scaleFactor: scaleFactor,
        ),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs(
          label: 'Apellidos',
          scaleFactor: scaleFactor,
        ),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs(
          label: 'Correo electrónico',
          scaleFactor: scaleFactor,
        ),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs(
          label: 'Contraseña',
          obscureText: true,
          scaleFactor: scaleFactor,
        ),
      ],
    );
  }
}
