import 'package:flutter/material.dart';
import 'package:fixnow/presentation/widgets/home/welcome_action_buttons.dart';

class WelcomeActions extends StatelessWidget {
  final double scaleFactor;
  const WelcomeActions({super.key, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionButton(
          icon: Icons.search,
          title: 'Buscar un servicio',
          subtitle: 'Encuentra al profesional ideal para tu hogar.',
          onPressed: () => Navigator.of(context).pushReplacementNamed('/register', arguments: 'cliente'),
          scaleFactor: scaleFactor,
        ),
        SizedBox(height: 20 * scaleFactor),
        ActionButton(
          icon: Icons.settings,
          title: 'Ofrecer un servicio',
          subtitle: 'Conecta con clientes y crece tu negocio.',
          onPressed: () => Navigator.of(context).pushReplacementNamed('/register', arguments: 'proveedor'),
          scaleFactor: scaleFactor,
        ),
      ],
    );
  }
}
