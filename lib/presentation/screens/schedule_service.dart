import 'package:fixnow/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleService extends StatelessWidget {
  const ScheduleService({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Agendar servicio',
          style: TextStyle(color: colors.primary),
        ),
      ),
      body: ScheduleServiceView(),
    );
  }
}

class ScheduleServiceView extends ConsumerWidget {
  ScheduleServiceView({super.key});

  final Map<String, int> _months = {
    'enero': 1,
    'febrero': 2,
    'marzo': 3,
    'abril': 4,
    'mayo': 5,
    'junio': 6,
    'julio': 7,
    'agosto': 8,
    'septiembre': 9,
    'octubre': 10,
    'noviembre': 11,
    'diciembre': 12,
  };
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final scheduleServicesState = ref.watch(scheduleServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Selecciona la fecha',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            const CalendarView(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Selecciona la hora',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            const SelectTime(),
            const SizedBox(
              height: 30,
            ),
            scheduleServicesState.day != ''
                ? const Text(
                    'Tu servicio quedará agendado para el día',
                    style: TextStyle(fontSize: 16),
                  )
                : const Text(''),
            scheduleServicesState.day != ''
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${scheduleServicesState.day} de ${scheduleServicesState.month} de ${scheduleServicesState.year}',
                        style: TextStyle(
                            fontSize: 16,
                            color: colors.primary,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        ' a las ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        scheduleServicesState.timeOfDay,
                        style: TextStyle(
                            fontSize: 16,
                            color: colors.primary,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                : Text(''),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                    onPressed: () {
                      try {
                        // Convertir el mes a su número correspondiente
                        final month = _months[scheduleServicesState.month.toLowerCase()] ?? 1;

                        // Combinar la fecha seleccionada
                        final selectedDate = DateTime(
                          int.parse(scheduleServicesState.year),
                          month,
                          int.parse(scheduleServicesState.day),
                        );

                        // Normalizar el formato de `timeOfDay`
                        final normalizedTimeOfDay = scheduleServicesState.timeOfDay.replaceAll('\u202F', ' ');

                        // Validar el formato de `timeOfDay`
                        if (!normalizedTimeOfDay.contains(' ')) {
                          throw FormatException('Formato de tiempo inválido: $normalizedTimeOfDay');
                        }

                        // Dividir `timeOfDay` en horas y período
                        final timeParts = normalizedTimeOfDay.split(' ');
                        if (timeParts.length != 2) {
                          throw FormatException('Formato de tiempo inesperado: $normalizedTimeOfDay');
                        }

                        final time = timeParts[0].split(':'); // Divide horas y minutos.
                        if (time.length != 2) {
                          throw FormatException('Formato de hora inválido: ${timeParts[0]}');
                        }

                        final period = timeParts[1]; // AM o PM.
                        int hour = int.parse(time[0]);
                        final int minute = int.parse(time[1]);

                        // Convertir hora a formato de 24 horas si es PM.
                        if (period == 'PM' && hour != 12) {
                          hour += 12;
                        } else if (period == 'AM' && hour == 12) {
                          hour = 0; // Medianoche en formato de 24 horas.
                        }

                        // Crear el objeto `DateTime` con la fecha y hora seleccionadas
                        final selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          hour,
                          minute,
                        );

                        print('Fecha y hora seleccionadas: $selectedDateTime');

                        // Navegar con los datos
                        context.push('/schedule/2', extra: {
                          'selectedDateTime': selectedDateTime,
                        });
                      } catch (e) {
                        // Mostrar error en la consola para depuración
                        print('Error procesando la fecha y hora: $e');

                        // Mostrar un mensaje de error al usuario
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error procesando la fecha y hora: $e'),
                            backgroundColor: Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                    },
     

                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 17),
                    child: Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key});

  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends ConsumerState<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        ref.read(scheduleServiceProvider.notifier).onDayChanged(_selectedDay!);
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}

class SelectTime extends ConsumerStatefulWidget {
  const SelectTime({super.key});

  @override
  SelectTimeState createState() => SelectTimeState();
}

class SelectTimeState extends ConsumerState<SelectTime> {
  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        final colors = Theme.of(context).colorScheme;
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: colors.surface,
              hourMinuteColor: colors.surfaceContainer,
              dayPeriodTextColor: colors.primary,
              dayPeriodColor: colors.surfaceContainer,
              hourMinuteTextColor: colors.primary,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _timeOfDay = value;
        });
        ref
            .read(scheduleServiceProvider.notifier)
            .onTimeOfDayChanged(_timeOfDay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.secondary,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colors.primary, width: 0.2),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: _showTimePicker,
        child: Text(_timeOfDay.format(context).toString()),
      ),
    );
  }
}
