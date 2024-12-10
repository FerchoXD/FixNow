import 'package:fixnow/infrastructure/datasources/message_with_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class GeminiMessageBubbleWithProviders extends StatelessWidget {
  final MessageWithProviders message;
  const GeminiMessageBubbleWithProviders({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mensaje del asistente
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              child: SvgPicture.asset(
                'assets/images/assistant.svg',
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        offset: const Offset(4, 4),
                        spreadRadius: 1,
                      ),
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    message.text,
                    style: TextStyle(color: colors.onSurface),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Lista de proveedores
        ...message.suppliers.map((supplier) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 50, bottom: 10), // Espaciado igual al ícono del asistente
            child: GestureDetector(
              onTap: () => context.push('/supplier/${supplier['uuid']}'),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        offset: const Offset(4, 4),
                        spreadRadius: 1,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre del proveedor
                      Text(
                        supplier['fullname'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colors.onSurface,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Servicios ofrecidos
                      Text(
                        'Especializado en: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${supplier['selectedservices'].join(', ')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Puntuación con estrellas
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < supplier['relevance']
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 20),
      ],
    );
  }
}
