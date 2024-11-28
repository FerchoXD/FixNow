import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivateCustomerProfile extends StatelessWidget {
  const PrivateCustomerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: _ProfileView(),
    );
  }
}

class _ProfileView extends ConsumerWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileImage(),
            const SizedBox(
              height: 20,
            ),
            Text(
              authState.user!.fullname,
              style: TextStyle(fontSize: 34, color: colors.onSurface),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: colors.onSurfaceVariant,
                      size: 30,
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ninguna',
                          style:
                              TextStyle(fontSize: 16, color: colors.onSurface),
                        ),
                        // Text(
                        //   'a 3 Km de distancia',
                        //   style:
                        //       TextStyle(fontSize: 16, color: colors.onSurface),
                        // ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_android,
                      color: colors.onSurfaceVariant,
                      size: 30,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      authState.user!.phoneNumber,
                      style: TextStyle(fontSize: 16, color: colors.onSurface),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Experiencia',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Precios y tarifas',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Disponibilidad horaria',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

