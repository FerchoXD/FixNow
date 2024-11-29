import 'package:fixnow/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CompletedProfile extends ConsumerWidget {
  const CompletedProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                  context.go('/home/0');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 17),
                child: Text(
                  'Aceptar',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }
}