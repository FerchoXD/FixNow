import 'package:fixnow/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fixnow/presentation/widgets.dart';

class RegisterUserScreen extends ConsumerWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final registerState = ref.watch(registerFormProvider);

    return Scaffold(
        backgroundColor: colors.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Únete',
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Regístrate para conectar con profesionales, u ofrece tus servicios de manera fácil.',
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    label: 'Nombre',
                    keyboardType: TextInputType.name,
                    onChanged:
                        ref.read(registerFormProvider.notifier).onNameChange,
                    errorMessage: registerState.isFormPosted
                        ? registerState.name.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Apellido',
                    keyboardType: TextInputType.text,
                    onChanged: ref
                        .read(registerFormProvider.notifier)
                        .onLastNameChange,
                    errorMessage: registerState.isFormPosted
                        ? registerState.lastName.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    onChanged:
                        ref.read(registerFormProvider.notifier).onEmailChange,
                    errorMessage: registerState.isFormPosted
                        ? registerState.email.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Teléfono',
                    keyboardType: TextInputType.phone,
                    onChanged: ref
                        .read(registerFormProvider.notifier)
                        .onPhoneNumberChange,
                    errorMessage: registerState.isFormPosted
                        ? registerState.phoneNumber.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Contraseña',
                    keyboardType: TextInputType.visiblePassword,
                    isObscureText: true,
                    onChanged: ref
                        .read(registerFormProvider.notifier)
                        .onPasswordChange,
                    errorMessage: registerState.isFormPosted
                        ? registerState.password.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: registerState.isPosting
                            ? null
                            : () {
                                ref
                                    .read(registerFormProvider.notifier)
                                    .onFormSubmit();
                              },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 17),
                          child: Text(
                            'Continuar',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'O conéctate con',
                    style: TextStyle(color: colors.onSurface, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Google',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/facebook.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Facebook',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text(
                      'Volver al inicio',
                      style: TextStyle(color: colors.primary, fontSize: 16),
                    ),
                  ),
                ])),
          ),
        ));
  }
}
