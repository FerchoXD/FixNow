import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                // ref.read(basicInfoProvider.notifier).onFormSubmit();
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