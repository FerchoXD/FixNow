import 'package:flutter/material.dart';

class PrivateProfileSuplier extends StatelessWidget {
  const PrivateProfileSuplier({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SupplierProfileView(),
    );
  }
}

class SupplierProfileView extends StatelessWidget {
  const SupplierProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
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
              'Alan Manuel',
              style: TextStyle(fontSize: 34, color: colors.onSurface),
            ),
            Text(
              'Gómez Vázquez',
              style: TextStyle(fontSize: 34, color: colors.onSurface),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < 4 ? Icons.star_rounded : Icons.star_border_rounded,
                  color: colors.primary,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Electricista',
                    style: TextStyle(
                      color: colors.onSecondaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                
              ],
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
                      '961 477 55 63',
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
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
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
                Text('\$350',
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
                Text('\$100',
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
            WorkSchedule()
          ],
        ),
      ),
    );
  }
}

class WorkSchedule extends StatelessWidget {
  const WorkSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final days = [
      {'day': 'Lunes', 'time': '8 Am - 5 Pm', 'isWorkingDay': true},
      {'day': 'Martes', 'time': '8 Am - 5 Pm', 'isWorkingDay': true},
      {'day': 'Miércoles', 'time': '8 Am - 5 Pm', 'isWorkingDay': true},
      {'day': 'Jueves', 'time': 'No laboral', 'isWorkingDay': false},
      {'day': 'Viernes', 'time': '8 Am - 5 Pm', 'isWorkingDay': true},
      {'day': 'Sábado', 'time': '8 Am - 5 Pm', 'isWorkingDay': true},
      {'day': 'Domingo', 'time': 'No laboral', 'isWorkingDay': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          physics:
              const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
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
                      color: day['isWorkingDay'] as bool
                          ? colors.primary
                          : colors.onSurfaceVariant,
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
                        day['day'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        day['time'] as String,
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
