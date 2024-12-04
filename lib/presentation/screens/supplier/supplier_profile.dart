import 'package:fixnow/presentation/providers/supplier/supplier_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProfileSuplier extends ConsumerWidget {
  final String supplierId;
  const ProfileSuplier({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final supplierState = ref.watch(supplierProfileProvider(supplierId));
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: colors.surface,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 120,
            child: FloatingActionButton.extended(
              heroTag: 'contratar',
              backgroundColor: colors.primary,
              onPressed: () {
                context.push('/schedule/$supplierId');
              },
              label: const Text('Contratar'),
              icon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 120,
            child: FloatingActionButton.extended(
              heroTag: 'chat',
              backgroundColor: colors.secondary,
              onPressed: () {
                context.push('/chat/${supplierState.supplier!.firstname}');
              },
              label: Text('Chat', style: TextStyle(color: colors.primary)),
              icon: Icon(Icons.chat, color: colors.primary),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 120,
            child: FloatingActionButton.extended(
              heroTag: 'reseñas',
              backgroundColor: colors.secondary,
              onPressed: () {
                context.push('/reviews');
              },
              label: Text('Reseñas', style: TextStyle(color: colors.primary)),
              icon: Icon(Icons.person, color: colors.primary),
            ),
          ),
        ],
      ),
      body: _SupplierProfileView(
        supplierId: supplierId,
      ),
    );
  }
}

class _SupplierProfileView extends ConsumerWidget {
  final String supplierId;
  const _SupplierProfileView({required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final supplierState = ref.watch(supplierProfileProvider(supplierId));
    final rating = supplierState.supplier != null
        ? supplierState.supplier!.relevance
        : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: supplierState.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  supplierState.supplier != null &&
                          supplierState.supplier!.images!.isNotEmpty
                      ? SizedBox(
                          height: 250, 
                          child: PageView.builder(
                            itemCount: supplierState.supplier!.images!.length,
                            controller: PageController(
                                viewportFraction: 1), 
                            itemBuilder: (context, index) {
                              final image =
                                  supplierState.supplier!.images![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    image, // URL de la imagen
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text('No images available'),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    supplierState.supplier != null
                        ? supplierState.supplier!.fullname
                        : '',
                    style: TextStyle(fontSize: 34, color: colors.onSurface),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < rating
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: colors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$rating',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      supplierState.supplier != null
                          ? supplierState.supplier!.selectedServices.length
                          : 0,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: colors.secondaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          supplierState.supplier != null
                              ? supplierState.supplier!.selectedServices[index]
                              : '', // Texto dinámico
                          style: TextStyle(
                            color: colors.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.location_on,
                      //       color: colors.onSurfaceVariant,
                      //       size: 30,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Ninguna',
                      //           style: TextStyle(
                      //               fontSize: 16, color: colors.onSurface),
                      //         ),
                      //         // Text(
                      //         //   'a 3 Km de distancia',
                      //         //   style:
                      //         //       TextStyle(fontSize: 16, color: colors.onSurface),
                      //         // ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android,
                            color: colors.onSurfaceVariant,
                            size: 30,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            supplierState.supplier != null
                                ? supplierState.supplier!.phone
                                : '',
                            style: TextStyle(
                                fontSize: 16, color: colors.onSurface),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Experiencia',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: colors.onSurface),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    supplierState.supplier != null
                        ? supplierState.supplier!.workexperience
                        : '',
                    style: TextStyle(fontSize: 16, color: colors.onSurface),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Precios y tarifas',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: colors.onSurface),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('A partir de ',
                          style:
                              TextStyle(fontSize: 16, color: colors.onSurface)),
                      Text(
                          '\$ ${supplierState.supplier != null ? supplierState.supplier!.standardPrice : ''}',
                          style: TextStyle(
                              fontSize: 24,
                              color: colors.primary,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Tarifa por hora: ',
                          style:
                              TextStyle(fontSize: 16, color: colors.onSurface)),
                      Text(
                          '\$ ${supplierState.supplier != null ? supplierState.supplier!.hourlyRate : ''}',
                          style: TextStyle(
                              fontSize: 24,
                              color: colors.primary,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Recuerda que puedes negociar los costos directamente con el proveedor.',
                    style: TextStyle(
                        color: colors.primary.withOpacity(0.8), fontSize: 16),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Disponibilidad horaria',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: colors.onSurface),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _WorkSchedule(supplierId: supplierId),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}

class _WorkSchedule extends ConsumerWidget {
  final String supplierId;
  const _WorkSchedule({required this.supplierId});

  String formatTime(String? time) {
    if (time == null) {
      return 'N/D';
    }
    final parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("h a").format(parsedTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final supplierState = ref.watch(supplierProfileProvider(supplierId));

    const dayOrder = {
      'Lunes': 1,
      'Martes': 2,
      'Miércoles': 3,
      'Jueves': 4,
      'Viernes': 5,
      'Sábado': 6,
      'Domingo': 7,
    };

    final sortedCalendar = List.from(
        supplierState.supplier != null ? supplierState.supplier!.calendar! : [])
      ..sort((a, b) => (dayOrder[a.day] ?? 8).compareTo(dayOrder[b.day] ?? 8));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3,
          ),
          itemCount: sortedCalendar.length,
          itemBuilder: (context, index) {
            final day = sortedCalendar[index];
            final scheduleText = day.active
                ? '${formatTime(day.start)} - ${formatTime(day.end)}'
                : 'No Disponible';

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colors.surface,
                border: Border.all(color: colors.outline),
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          day.active ? colors.primary : colors.onSurfaceVariant,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.day,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        scheduleText,
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
