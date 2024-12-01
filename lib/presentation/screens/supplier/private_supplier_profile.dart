import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PrivateProfileSuplier extends StatelessWidget {
  const PrivateProfileSuplier({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: const SupplierProfileView(),
    );
  }
}

class SupplierProfileView extends ConsumerWidget {
  const SupplierProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(authProvider);
    final rating = userState.user!.relevance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assets/images/carpinteria2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              userState.user != null ? userState.user!.fullname : '',
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
                userState.user != null
                    ? userState.user!.selectedServices.length
                    : 0,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userState.user != null
                        ? userState.user!.selectedServices[index]
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
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: colors.onSurfaceVariant,
                      size: 30,
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ninguna',
                          style:
                              TextStyle(fontSize: 16, color: colors.onSurface),
                        ),
                        // Text(
                        //   'a 3 Km de distancia',
                        //   style:
                        //       TextStyle(fontSize: 16, color: colors.onSurface),
                        // ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_android,
                      color: colors.onSurfaceVariant,
                      size: 30,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      userState.user != null ? userState.user!.phoneNumber : '',
                      style: TextStyle(fontSize: 16, color: colors.onSurface),
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
              userState.user != null ? userState.user!.workExperience : '',
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
                    style: TextStyle(fontSize: 16, color: colors.onSurface)),
                Text(
                    '\$ ${userState.user != null ? userState.user!.standardPrice : ''}',
                    style: TextStyle(
                        fontSize: 24,
                        color: colors.primary,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              children: [
                Text('Tarifa por hora: ',
                    style: TextStyle(fontSize: 16, color: colors.onSurface)),
                Text(
                    '\$ ${userState.user != null ? userState.user!.hourlyRate : userState.user!.hourlyRate}',
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
            const WorkSchedule(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class WorkSchedule extends ConsumerWidget {
  const WorkSchedule({super.key});

  String formatTime(String? time) {
    if (time == null) {
      return 'N/D'; // Devuelve "No Disponible" si el tiempo es nulo
    }
    final parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("h a").format(parsedTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(authProvider);

    const dayOrder = {
      'Lunes': 1,
      'Martes': 2,
      'Miércoles': 3,
      'Jueves': 4,
      'Viernes': 5,
      'Sábado': 6,
      'Domingo': 7,
    };

    final sortedCalendar = List.from(userState.user!.calendar)
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
