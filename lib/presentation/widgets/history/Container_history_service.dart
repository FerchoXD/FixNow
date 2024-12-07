import 'package:fixnow/presentation/providers/service/history_provider.dart';
import 'package:fixnow/presentation/widgets/history/history_modal_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ContainerHistoryService extends ConsumerWidget {
  final List<dynamic> services;
  final HistoryOption selectedOption;
  final String userId;
  final String role;
  const ContainerHistoryService(
      {super.key,
      required this.services,
      required this.selectedOption,
      required this.userId,
      required this.role});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    // Filtrar servicios según la opción seleccionada.
    final filteredServices = _filterServices(services, selectedOption);

    if (filteredServices.isEmpty) {
      return Center(
        child: Text(
          'No hay datos disponibles.',
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
      );
    }

    // Ordenar los servicios por `createdAt` (de más reciente a más antiguo).
    final sortedServices = [...filteredServices];
    sortedServices.sort((a, b) {
      final DateTime dateA = DateTime.parse(a['createdAt']);
      final DateTime dateB = DateTime.parse(b['createdAt']);
      return dateB.compareTo(dateA);
    });

    void _showReviewModal(BuildContext context, String title,
        String description, String createdAt) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Permite que el modal se ajuste al teclado
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Espacio dinámico según el teclado
            ),
            child: HistoryModalView(
              title: title,
              description: description,
              createdAt: createdAt,
            ),
          );
        },
      );
    }

    return ListView.builder(
      itemCount: sortedServices.length,
      itemBuilder: (context, index) {
        final service = sortedServices[index];
        final number = index + 1;
        final title = service['title'] ?? 'Sin título';
        final description = service['description'] ?? 'Sin descripción';
        final status = service['status'] ?? 'Desconocido';
        final createdAt = service['createdAt'] ?? 'Fecha inválida';

        final timeAgo = _formatTimeAgo(createdAt);

        return GestureDetector(
          onTap: () {
            _showReviewModal(context, title, description, createdAt);
          },
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      _getColorBasedOnStatus(status, colors).withOpacity(0.2),
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
                        style: TextStyle(
                            color: colors.onSurfaceVariant, fontSize: 16),
                      ),
                      Text(
                        'Solicitado $timeAgo',
                        style: TextStyle(
                            color: colors.onSurfaceVariant, fontSize: 14),
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
          ),
        );
      },
    );
  }

  List<dynamic> _filterServices(List<dynamic> services, HistoryOption option) {
    if (option == HistoryOption.all) {
      return services; // No se aplica filtro.
    }

    // Mapeo de opciones a claves de estado.
    final statusMapping = {
      HistoryOption.pending: 'PENDING',
      HistoryOption.progress: 'IN_PROGRESS',
      HistoryOption.canceled: 'CANCELLED',
    };

    return services.where((service) {
      return service['status'] == statusMapping[option];
    }).toList();
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'PENDING':
        return 'Pendiente';
      case 'PROGRESS':
        return 'En progreso';
      case 'C':
        return 'Cancelado';
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
      case 'IN_PROGRESS':
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
