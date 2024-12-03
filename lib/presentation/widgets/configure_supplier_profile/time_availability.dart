import 'package:fixnow/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeAvailability extends ConsumerStatefulWidget {
  const TimeAvailability({super.key});

  @override
  _TimeAvailabilityState createState() => _TimeAvailabilityState();
}

class _TimeAvailabilityState extends ConsumerState<TimeAvailability> {
  final Map<String, String> _schedule = {
    'Lunes': '08:00 - 17:00',
    'Martes': '08:00 - 17:00',
    'Miércoles': '08:00 - 17:00',
    'Jueves': '08:00 - 17:00',
    'Viernes': '08:00 - 17:00',
    'Sábado': '08:00 - 17:00',
    'Domingo': '08:00 - 17:00',
  };

  final Map<String, bool> _isNonWorkingDay = {
    'Lunes': false,
    'Martes': false,
    'Miércoles': false,
    'Jueves': false,
    'Viernes': false,
    'Sábado': false,
    'Domingo': false,
  };

  String? _selectedDay;

  // Para almacenar el calendario que se enviará en el formato adecuado
  List<Map<String, dynamic>> get calendar {
    return _schedule.keys.map((day) {
      bool isNonWorking = _isNonWorkingDay[day] ?? false;
      return {
        'day': day,
        'activo': !isNonWorking,
        'inicio': isNonWorking ? null : _schedule[day]?.split(' - ')[0],
        'fin': isNonWorking ? null : _schedule[day]?.split(' - ')[1],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final timeState = ref.watch(timeProvider);
    final authState = ref.watch(authProvider);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.5,
              child: ListView.builder(
                itemCount: _schedule.keys.length,
                itemBuilder: (context, index) {
                  String day = _schedule.keys.elementAt(index);
                  bool isSelected = _selectedDay == day;
                  bool isNonWorkingDay = _isNonWorkingDay[day] ?? false;

                  return GestureDetector(
                    onTap: () {
                      if (!isNonWorkingDay) {
                        setState(() {
                          _selectedDay = day;
                        });
                        _selectTimeRange(context, day);
                      }
                      ref
                          .read(timeProvider.notifier)
                          .onScheduleChanged(calendar);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        border: Border(
                          left: BorderSide(
                            color: isSelected
                                ? Colors.blue
                                : (isNonWorkingDay ? Colors.grey : Colors.blue),
                            width: screenWidth * 0.02,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: devicePixelRatio * 5,
                            offset: Offset(0, devicePixelRatio * 1.5),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          day,
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: isNonWorkingDay ? Colors.grey : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          _schedule[day] == 'No laboral'
                              ? 'No laboral'
                              : convertTo12HourFormat(_schedule[day]!),
                          style: TextStyle(
                            color: isNonWorkingDay ? Colors.grey : Colors.black,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "No laboral",
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: isNonWorkingDay
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            Checkbox(
                              value: isNonWorkingDay,
                              onChanged: (value) {
                                if (value != null &&
                                    value == true &&
                                    !_canMarkAsNonWorkingDay(day)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Debe haber al menos un día laboral.'),
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  _isNonWorkingDay[day] = value ?? false;
                                  _schedule[day] = (value ?? false)
                                      ? 'No laboral'
                                      : '08:00 - 17:00';
                                  if (value == true) {
                                    _selectedDay = null;
                                  }
                                });
                                ref
                                    .read(timeProvider.notifier)
                                    .onScheduleChanged(calendar);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: timeState.isPosting ?  null : () {
                    ref.read(timeProvider.notifier).onFormSubmit(authState.user!.id!);
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

  Future<void> _selectTimeRange(BuildContext context, String day) async {
    final colors = Theme.of(context).colorScheme;
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: Theme.of(context).copyWith(
                timePickerTheme: TimePickerThemeData(
              backgroundColor: colors.surface,
              hourMinuteColor: colors.surfaceContainer,
              dayPeriodTextColor: colors.primary,
              dayPeriodColor: colors.surfaceContainer,
              hourMinuteTextColor: colors.primary,
            )),
            child: child!);
      },
    );

    if (startTime != null) {
      TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 17, minute: 0),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  timePickerTheme: TimePickerThemeData(
                backgroundColor: colors.surface,
                hourMinuteColor: colors.surfaceContainer,
                dayPeriodTextColor: colors.primary,
                dayPeriodColor: colors.surfaceContainer,
                hourMinuteTextColor: colors.primary,
              )),
              child: child!);
        },
      );

      if (endTime != null) {
        setState(() {
          // Aquí se convierte el formato a 24 horas
          String startHour = startTime.hour.toString().padLeft(2, '0');
          String startMinute = startTime.minute.toString().padLeft(2, '0');
          String endHour = endTime.hour.toString().padLeft(2, '0');
          String endMinute = endTime.minute.toString().padLeft(2, '0');
          _schedule[day] = '$startHour:$startMinute - $endHour:$endMinute';
          _isNonWorkingDay[day] = false;
        });
      }
    }
  }

  bool _canMarkAsNonWorkingDay(String day) {
    int workingDaysCount =
        _isNonWorkingDay.values.where((isNonWorking) => !isNonWorking).length;
    return workingDaysCount > 1;
  }

  String convertTo12HourFormat(String time24) {
    final timeParts = time24.split(' - ');
    if (timeParts.length == 2) {
      String startTime = timeParts[0];
      String endTime = timeParts[1];

      // Función para convertir una hora de 24 horas a 12 horas AM/PM
      String formatTime(String time) {
        final hour = int.parse(time.split(':')[0]);
        final minute = time.split(':')[1];
        final isAM = hour < 12;
        final hour12 = hour % 12 == 0 ? 12 : hour % 12;
        final ampm = isAM ? 'AM' : 'PM';
        return '$hour12:$minute $ampm';
      }

      return '${formatTime(startTime)} - ${formatTime(endTime)}';
    }
    return time24; // Retorna el mismo valor si no tiene un formato de horas
  }
}
