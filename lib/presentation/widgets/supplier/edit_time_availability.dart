import 'package:fixnow/domain/entities/calendar_supplier.dart';
import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/providers/supplier/edit_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTimeAvailability extends ConsumerStatefulWidget {
  final User user;
  const EditTimeAvailability({super.key, required this.user});

  @override
  _TimeAvailabilityState createState() => _TimeAvailabilityState();
}

class _TimeAvailabilityState extends ConsumerState<EditTimeAvailability> {
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

  @override
  void initState() {
    super.initState();
    _initializeScheduleFromCalendar();
  }

  void _initializeScheduleFromCalendar() {
    final editProfile = ref.read(editProfileProvider(widget.user));
    final calendarByUser = editProfile.user.calendar;

    for (var entry in calendarByUser!) {
      if (entry is CalendarSupplier) {
        final day = entry.day;
        final isActive = entry.active;
        final startTime = entry.start ?? '08:00:00';
        final endTime = entry.end ?? '17:00:00';

        // Actualizar el horario y estado laboral según el calendario
        if (_schedule.containsKey(day)) {
          _schedule[day] = isActive ? '$startTime - $endTime' : 'No laboral';
          _isNonWorkingDay[day] = !isActive;
        }
      }
    }

    setState(() {}); 
  }

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
    final editProfile = ref.watch(editProfileProvider(widget.user));
    final calendarByUser = editProfile.user.calendar;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _schedule.keys.map((day) {
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
            ref.read(timeProvider.notifier).onScheduleChanged(calendar);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                left: BorderSide(
                  color: isSelected
                      ? colors.primary
                      : (isNonWorkingDay ? Colors.grey : colors.primary),
                  width: 4,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                day,
                style: TextStyle(
                  fontSize: 16,
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
                      fontSize: 14,
                      color: isNonWorkingDay ? Colors.grey : Colors.black,
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
                            content:
                                Text('Debe haber al menos un día laboral.'),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        _isNonWorkingDay[day] = value ?? false;
                        _schedule[day] =
                            (value ?? false) ? 'No laboral' : '08:00 - 17:00';
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
      }).toList(),
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
