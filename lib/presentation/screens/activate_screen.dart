import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ActivateScreen extends StatelessWidget {
  const ActivateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ActivateScreenView(),
    );
  }
}

class ActivateScreenView extends ConsumerWidget {
  const ActivateScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final codeState = ref.watch(codeProvider);
    final registerState = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.authStatus == AuthStatus.accountActivated) {
        if (registerState.role == 'suplier') {
          context.go('/login');
        }
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verificación',
            style: TextStyle(
              color: Color(0xFF4C98E9),
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
              'Hemos enviado un código de verificación a tu correo, por favor ingresa el codigo para continuar'),
          const SizedBox(height: 40),
          CustomTextField(
            label: 'Código',
            onChanged: ref.read(codeProvider.notifier).onCodeChanged,
            errorMessage: codeState.isSent ? codeState.code.errorMessage : null,
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
                onPressed: codeState.isPosting
                    ? null
                    : () {
                        ref.read(codeProvider.notifier).onCodeSubmit();
                      },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
