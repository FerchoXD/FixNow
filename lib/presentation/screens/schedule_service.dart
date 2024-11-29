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
      body: const ScheduleServiceView(),
    );
  }
}

class ScheduleServiceView extends ConsumerStatefulWidget {
  const ScheduleServiceView({super.key});

  @override
  _ScheduleServiceViewState createState() => _ScheduleServiceViewState();
}

class _ScheduleServiceViewState extends ConsumerState<ScheduleServiceView> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _showTimePicker() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        final colors = Theme.of(context).colorScheme;
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: colors.surface,
              hourMinuteColor: colors.surfaceContainer,
              dayPeriodColor: colors.surfaceContainer,
              hourMinuteTextColor: colors.primary,
              dayPeriodTextColor: colors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }

  void _continueToNextScreen(BuildContext context) {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una fecha y una hora.')),
      );
      return;
    }

    final selectedDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    context.push(
      '/schedule/2',
      extra: selectedDateTime.toIso8601String(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Selecciona la fecha',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _selectedDate ?? DateTime.now(),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, _) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showTimePicker,
            child: Text(
              _selectedTime?.format(context) ?? 'Selecciona la hora',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => _continueToNextScreen(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Continuar',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
