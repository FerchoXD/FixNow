import 'package:fixnow/presentation/providers/service/schedule_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleService extends StatelessWidget {
  final String supplierId;
  const ScheduleService({super.key, required this.supplierId});

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
      body: ScheduleServiceView(supplierId: supplierId),
    );
  }
}

class ScheduleServiceView extends ConsumerStatefulWidget {
  final String supplierId;
  const ScheduleServiceView({super.key, required this.supplierId});

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
      ref
          .read(scheduleServiceProvider.notifier)
          .onTimeOfDayChanged(selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color.fromARGB(255, 255, 229, 227),
        textColor: Colors.red.shade300,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Selecciona la fecha',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(4, 4),
                    spreadRadius: 1,
                  ),
                ]),
            child: TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _selectedDate ?? DateTime.now(),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onDaySelected: (selectedDay, _) {
                setState(() {
                  _selectedDate = selectedDay;
                  ref
                      .read(scheduleServiceProvider.notifier)
                      .onDayChanged(_selectedDate!);
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(
                  color: colors.onSurfaceVariant,
                ),
                defaultTextStyle: TextStyle(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                headerMargin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                leftChevronIcon:
                    const Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon:
                    const Icon(Icons.chevron_right, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Selecciona la hora',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colors.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: _showTimePicker,
            child: Text(
              _selectedTime?.format(context) ?? 'Hora',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 50,
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
                  if (_selectedDate == null || _selectedTime == null) {
                    showToast(
                        'Por favor selecciona una fecha y hora para continuar.');
                  } else {
                    context.push('/schedule/2/${widget.supplierId}}');
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
    );
  }
}
