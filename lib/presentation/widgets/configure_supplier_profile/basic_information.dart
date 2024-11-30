import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicInformation extends ConsumerWidget {
  const BasicInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final basicInfoState = ref.watch(basicInfoProvider);
    final authState = ref.watch(authProvider);
    return Column(
      children: [
        CustomTextField(
          label: 'Nombre',
          onChanged: ref.read(basicInfoProvider.notifier).onNameChange,
          errorMessage: basicInfoState.isFormPosted
              ? basicInfoState.name.errorMessage
              : null,
              initialValue: authState.userTemp!.firstName,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          label: 'Apellido',
          onChanged: ref.read(basicInfoProvider.notifier).onLastNameChange,
          errorMessage: basicInfoState.isFormPosted
              ? basicInfoState.lastName.errorMessage
              : null,
              initialValue: authState.userTemp!.lastName,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          label: 'Correo',
          onChanged: ref.read(basicInfoProvider.notifier).onEmailChange,
          errorMessage: basicInfoState.isFormPosted
              ? basicInfoState.email.errorMessage
              : null,
          initialValue: authState.userTemp!.email,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          label: 'Telefono',
          keyboardType: TextInputType.number,
          onChanged: ref.read(basicInfoProvider.notifier).onPhoneNumberChange,
          errorMessage: basicInfoState.isFormPosted
              ? basicInfoState.phoneNumber.errorMessage
              : null,
              initialValue: authState.userTemp!.phone,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          label: 'Ubicación',
          onChanged: ref.read(basicInfoProvider.notifier).onLocationChanged,
          errorMessage: basicInfoState.isFormPosted
              ? basicInfoState.location.errorMessage
              : null,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: basicInfoState.isPosting ? null : () {
                ref.read(basicInfoProvider.notifier).onFormSubmit(authState.userTemp!.uuid);
                print(basicInfoState.isCompleted);
                
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
