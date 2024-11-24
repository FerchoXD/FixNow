import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

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
              'FixNow',
              style: TextStyle(
                color: colors.primary,
                fontSize: 62,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Tu aliado inteligente para el cuidado del hogar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    context.push('/user/select');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 17),
                    child: Text(
                      'Registarse',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.secondary,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colors.primary, width: 0.2),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    context.push('/login');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                          color: colors.primary,),
                    ),
                  )),
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
