import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkExperience extends ConsumerWidget {
  const WorkExperience({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final experienceState = ref.watch(experienceProvider);
    final authState = ref.watch(authProvider);
    return Column(
      children: [
        CustomTextField(
          label: 'Escribe aquí...',
          maxLines: 6,
          onChanged: ref.read(experienceProvider.notifier).onExperienceChanged,
          errorMessage: experienceState.isFormPosted
              ? experienceState.experience.errorMessage
              : null,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: experienceState.isPosting ? null : () {
                ref.read(experienceProvider.notifier).onFormSubmit(authState.user!.id);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 17),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }
}
