import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Historial',
          style: TextStyle(color: colors.primary),
        ),
      ),
      body: HistoryView(),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Buscar...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              // contentPadding:
              //     const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text('Todos')),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Completados',
                    style: TextStyle(color: colors.onSurfaceVariant),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'En proceso',
                    style: TextStyle(color: colors.onSurfaceVariant),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Cancelado',
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ContainerHistoryService(),
        ],
      ),
    );
  }
}

class ContainerHistoryService extends StatelessWidget {
  const ContainerHistoryService({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final services = [
      {'status': 'progress', 'title': 'Servicio de fontanería', 'subtitle': 'Servicio de fontanería', 'number': '3', 'days': '4'},
      {'status': 'completed', 'title': 'Servicio de carpintería', 'subtitle': 'Servicio de carpintería', 'number': '2', 'days': '10'},
      {'status': 'canceled', 'title': 'Servicio de carpintería', 'subtitle': 'Servicio de carpintería', 'number': '1', 'days': '15'},
    ];

    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _getColorBasedOnStatus(service['status'] as String, colors).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${service['number']} ${service['title']}',
                        style: TextStyle(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        service['subtitle'] as String,
                        style: TextStyle(color: colors.onSurfaceVariant, fontSize: 16),
                      ),
                      Text(
                        'Solicitado hace ${service['days']} días',
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
                    color: _getColorBasedOnStatus(service['status'] as String, colors),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _getStatusLabel(service['status'] as String),
                    style: TextStyle(color: colors.onSurface),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'progress':
        return 'En proceso';
      case 'completed':
        return 'Completado';
      case 'canceled':
        return 'Cancelado';
      default:
        return 'Desconocido';
    }
  }

  Color _getColorBasedOnStatus(String status, ColorScheme colors) {
    switch (status) {
      case 'progress':
        return colors.surfaceContainer;
      case 'completed':
        return colors.surfaceContainerHigh;
      case 'canceled':
        return colors.errorContainer;
      default:
        return colors.primary;
    }
  }
}
