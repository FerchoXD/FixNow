import 'package:flutter/material.dart';

class ContainerHistoryService extends StatelessWidget {
  final List<dynamic> services;
  const ContainerHistoryService({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (services.isEmpty) {
      return Center(
        child: Text(
          'No hay datos disponibles.',
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
      );
    }

    // Ordenar los servicios por `createdAt` (de más reciente a más antiguo).
    final sortedServices = [...services];
    sortedServices.sort((a, b) {
      final DateTime dateA = DateTime.parse(a['createdAt']);
      final DateTime dateB = DateTime.parse(b['createdAt']);
      return dateB.compareTo(dateA); // Más recientes primero.
    });

    return ListView.builder(
      itemCount: sortedServices.length,
      itemBuilder: (context, index) {
        final service = sortedServices[index];
        final number = index + 1;
        final title = service['title'] ?? 'Sin título';
        final description = service['description'] ?? 'Sin descripción';
        final status = service['status'] ?? 'Desconocido';
        final createdAt = service['createdAt'] ?? 'Fecha inválida';

        // Calcular hace cuánto tiempo se creó.
        final timeAgo = _formatTimeAgo(createdAt);

        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: _getColorBasedOnStatus(status, colors).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#$number - $title',
                      style: TextStyle(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(color: colors.onSurfaceVariant, fontSize: 16),
                    ),
                    Text(
                      'Solicitado $timeAgo',
                      style: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: _getColorBasedOnStatus(status, colors),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _getStatusLabel(status),
                  style: TextStyle(color: colors.onSurface),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'PENDING':
        return 'En proceso';
      case 'CONFIRMED':
        return 'Completado';
      case 'CANCELLED':
        return 'Cancelado';
      default:
        return 'Desconocido';
    }
  }

  Color _getColorBasedOnStatus(String status, ColorScheme colors) {
    switch (status) {
      case 'PENDING':
        return colors.surfaceContainer;
      case 'CONFIRMED':
        return colors.secondary;
      case 'CANCELLED':
        return colors.errorContainer;
      default:
        return colors.primary;
    }
  }

  String _formatTimeAgo(String createdAt) {
    try {
      // Convertir `createdAt` a un objeto `DateTime`.
      final DateTime createdDate = DateTime.parse(createdAt);
      final Duration difference = DateTime.now().difference(createdDate);

      if (difference.inDays > 0) {
        return 'hace ${difference.inDays} días';
      } else if (difference.inHours > 0) {
        return 'hace ${difference.inHours} horas';
      } else if (difference.inMinutes > 0) {
        return 'hace ${difference.inMinutes} minutos';
      } else {
        return 'hace unos segundos';
      }
    } catch (e) {
      return 'Fecha inválida';
    }
  }
}
