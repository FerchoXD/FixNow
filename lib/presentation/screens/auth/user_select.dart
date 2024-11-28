import 'package:fixnow/presentation/providers/auth/register_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class UserSelect extends ConsumerWidget {
  const UserSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

             Text(
              'Selecciona una opción',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            ActionButton(
              icon: Icons.search,
              title: 'Buscar un servicio',
              subtitle: 'Encuentra al profesional ideal para tu hogar.',
              onPressed: () {
                ref.read(registerFormProvider.notifier).onRoleChange('CUSTOMER');
                context.push('/register');
              },
            ),
            const SizedBox(height: 20),
            ActionButton(
              icon: Icons.settings,
              title: 'Ofrecer un servicio',
              subtitle: 'Conecta con clientes y crece tu negocio.',
              onPressed: () {
                ref.read(registerFormProvider.notifier).onRoleChange('SUPPLIER');
                context.push('/register');
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const ActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icono dentro de un cuadro negro
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 20),

          // Usamos Flexible para evitar el desbordamiento
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:  TextStyle(
                    color: colors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style:  TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
