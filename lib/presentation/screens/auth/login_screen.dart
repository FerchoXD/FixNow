import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    showMessage(BuildContext context, String message) {
      Fluttertoast.showToast(
        msg: message,
        fontSize: 16,
        backgroundColor: const Color.fromARGB(255, 255, 229, 227),
        textColor: Colors.red.shade300,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    final colors = Theme.of(context).colorScheme;
    final loginState = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.message.isEmpty) return;
      showMessage(context, next.message);
    });

    return Scaffold(
      backgroundColor: colors.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bienvenido',
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
                    'Por favor ingresa tus datos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  label: 'Correo eletrónico',
                  onChanged:
                      ref.read(loginFormProvider.notifier).onEmailChanged,
                  errorMessage: loginState.isFormPosted
                      ? loginState.email.errorMessage
                      : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Contraseña',
                  isObscureText: true,
                  onChanged:
                      ref.read(loginFormProvider.notifier).onPasswordChanged,
                  errorMessage: loginState.isFormPosted
                      ? loginState.password.errorMessage
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
                      onPressed: loginState.isPosting
                          ? null
                          : () {
                              ref
                                  .read(loginFormProvider.notifier)
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
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    context.push('/user/select');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No tienes cuenta? ',
                        style: TextStyle(
                            color: colors.onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'Regístrate',
                        style: TextStyle(
                            color: colors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
