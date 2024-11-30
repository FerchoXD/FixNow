import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/providers/service/SupplierService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AssistantScreen extends ConsumerWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    final TextEditingController promptController = TextEditingController();

    void sendPrompt() async {
    final prompt = promptController.text.trim(); // Elimina espacios en blanco
    final token = authState.user?.token;

    FocusScope.of(context).unfocus();

    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, escribe un problema.')),
      );
      return;
    }

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo realizar la acción.')),
      );
      return;
    }

    try {
      final suppliers = await SupplierService().fetchSuppliers(prompt, token);

      if (suppliers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se encontraron proveedores.')),
        );
      } else {
        GoRouter.of(context).go(
          '/home/0',
          extra: suppliers, // Pasar datos
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.assistant,
              color: colors.primary,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Buen día, ${authState.user!.fullname}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '¿Cuál es tu problema?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: promptController,
                      decoration: InputDecoration(
                        hintText: 'Escribe aquí...',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colors.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.5)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(113, 48, 48, 48),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.5)),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: sendPrompt,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      backgroundColor: colors.primary,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
