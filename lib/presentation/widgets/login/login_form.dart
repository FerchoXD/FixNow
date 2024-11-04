import 'package:fixnow/presentation/widgets/customized_inputs.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final double scaleFactor;
  const LoginForm({super.key, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomizedInputs(
          scaleFactor: scaleFactor,
          label: "Correo electrónico",
        ),
        SizedBox(height: 20 * scaleFactor),
        CustomizedInputs(
          scaleFactor: scaleFactor,
          label: "Contraseña",
        ),
      ],
    );
  }
}