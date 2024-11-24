import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final scheduleServiceProvider =
    StateNotifierProvider<ScheduleServiceNotifier, ScheduleServiceState>((ref) {
  return ScheduleServiceNotifier();
});

class ScheduleServiceState {
  final String timeOfDay;
  final String day;
  final String month;
  final String year;

  const ScheduleServiceState({
    this.timeOfDay = '8:30 AM',
    this.day = '',
    this.month = '',
    this.year = '',
  });

  ScheduleServiceState copyWith({
    String? timeOfDay,
    String? day,
    String? month,
    String? year,
  }) =>
      ScheduleServiceState(
        timeOfDay: timeOfDay ?? this.timeOfDay,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
      );
}

class ScheduleServiceNotifier extends StateNotifier<ScheduleServiceState> {
  ScheduleServiceNotifier() : super(ScheduleServiceState());

  void onTimeOfDayChanged(TimeOfDay value) {
    final String newTime = formatTimeOfDay(value);
    state = state.copyWith(timeOfDay: newTime);
  }

  void onDayChanged(DateTime value) {
    final String newDay = value.day.toString();
    final String newMonth = DateFormat.MMMM('es').format(value);
    final String newYear = value.year.toString();
    state = state.copyWith(day: newDay, month: newMonth, year: newYear);
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    final DateFormat formatter = DateFormat.jm();
    return formatter.format(dateTime);
  }
}
