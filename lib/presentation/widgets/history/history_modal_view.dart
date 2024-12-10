import 'package:intl/intl.dart'; // Importa intl
import 'package:fixnow/presentation/providers/service/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryModalView extends ConsumerWidget {
  final String title;
  final String description;
  final String createdAt;
  final String serviceUuid;
  final String status;
  const HistoryModalView({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.serviceUuid,
    required this.status,
  });

  String formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate); // Convierte la cadena en DateTime
      return DateFormat('d \'de\' MMMM \'de\' y', 'es').format(date);
      // 'es' es para el idioma español
    } catch (e) {
      return 'Fecha inválida';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    ref.listen(historyProvider, (previous, next) {
      if (next.isStatusUpdated) {
        context.pop();
      }
    });

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Detalles de servicio',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.primary),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Título: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colors.primary),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Descripción: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colors.primary),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fecha: ',
                  style: TextStyle(
                      fontSize: 16,
                      color: colors.primary,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  formatDate(createdAt),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                status == 'CANCELLED' || status == 'DONE'
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          ref
                              .read(historyProvider.notifier)
                              .changeStatusService(serviceUuid, 'CANCELLED');
                        },
                        child: Text(
                          'Rechazar',
                          style: TextStyle(color: Colors.red.shade300),
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Colors.red.withOpacity(0.1)),
                        ),
                      ),
                const SizedBox(width: 20),
                status == 'CANCELLED' || status == 'DONE'
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          ref
                              .read(historyProvider.notifier)
                              .changeStatusService(
                                serviceUuid,
                                status == 'CONFIRMED' ? 'DONE' : 'CONFIRMED',
                              );
                        },
                        child: status == 'CONFIRMED'
                            ? Text(
                                'Terminar',
                                style: TextStyle(color: Colors.green.shade300),
                              )
                            : Text(
                                'Aceptar',
                                style: TextStyle(color: Colors.blue.shade300),
                              ),
                        style: status == 'CONFIRMED'
                            ? ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.green.withOpacity(0.1)),
                              )
                            : ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.blue.withOpacity(0.1)),
                              ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
