import 'package:fixnow/infrastructure/datasources/customer_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/infrastructure/inputs/standar_price.dart';
import 'package:fixnow/infrastructure/inputs/standar_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

final scheduleServiceProvider =
    StateNotifierProvider<ScheduleServiceNotifier, ScheduleServiceState>((ref) {
  final customerData = CustomerData();
  return ScheduleServiceNotifier(customerData: customerData);
});

class ScheduleServiceState {
  final DateTime? dateTime;
  final TimeOfDay? timeOfDayInit;
  final String timeOfDay;
  final String day;
  final String month;
  final String year;
  final bool isValid;
  final StandarText title;
  final StandarText description;
  final StandarPrice price;
  final bool isFormPosted;
  final bool isPosting;
  final String successMessage;

  const ScheduleServiceState({
    this.dateTime,
    this.timeOfDayInit,
    this.timeOfDay = '',
    this.day = '',
    this.month = '',
    this.year = '',
    this.isValid = false,
    this.title = const StandarText.pure(),
    this.description = const StandarText.pure(),
    this.price = const StandarPrice.pure(),
    this.isFormPosted = false,
    this.isPosting = false,
    this.successMessage = '',
  });

  ScheduleServiceState copyWith(
          {DateTime? dateTime,
          TimeOfDay? timeOfDayInit,
          String? timeOfDay,
          String? day,
          String? month,
          String? year,
          bool? isValid,
          StandarText? title,
          StandarText? description,
          StandarPrice? price,
          bool? isFormPosted,
          bool? isPosting,
          String? successMessage}) =>
      ScheduleServiceState(
          dateTime: dateTime ?? this.dateTime,
          timeOfDayInit: timeOfDayInit ?? this.timeOfDayInit,
          timeOfDay: timeOfDay ?? this.timeOfDay,
          day: day ?? this.day,
          month: month ?? this.month,
          year: year ?? this.year,
          isValid: isValid ?? this.isValid,
          title: title ?? this.title,
          description: description ?? this.description,
          price: price ?? this.price,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isPosting: isPosting ?? this.isValid,
          successMessage: successMessage ?? this.successMessage);
}

class ScheduleServiceNotifier extends StateNotifier<ScheduleServiceState> {
  final CustomerData customerData;
  ScheduleServiceNotifier({required this.customerData})
      : super(const ScheduleServiceState());

  void onTimeOfDayChanged(TimeOfDay value) {
    final String newTime = formatTimeOfDay(value);
    state = state.copyWith(timeOfDay: newTime, timeOfDayInit: value);
  }

  void onDayChanged(DateTime value) {
    final String newDay = value.day.toString();
    final String newMonth = DateFormat.MMMM('es').format(value);
    final String newYear = value.year.toString();

    state = state.copyWith(
        day: newDay, month: newMonth, year: newYear, dateTime: value);
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    final DateFormat formatter = DateFormat.jm();
    return formatter.format(dateTime);
  }

  void onTitleChanged(String value) {
    final newTitle = StandarText.dirty(value);
    state = state.copyWith(title: newTitle);
  }

  void onDescriptionChanged(String value) {
    final newDescription = StandarText.dirty(value);
    state = state.copyWith(description: newDescription);
  }

  void onPriceChanged(double value) {
    final newPrice = StandarPrice.dirty(value);
    state = state.copyWith(price: newPrice);
  }

  Future onFormSubmit(String userId, String supplierId) async {
    _touchEveryField();
    if (!state.isValid) return;
    final agreedDate = formatDateTime(state.dateTime!, state.timeOfDayInit!);
    try {
      state = state.copyWith(isPosting: true);
      final succesMessage = await customerData.createSercie(
          userId,
          supplierId,
          state.title.value,
          state.description.value,
          state.price.value,
          agreedDate);
      state = state.copyWith(successMessage: succesMessage);
    } on CustomError catch (e) {}
    state = const ScheduleServiceState();
  }

  String formatDateTime(DateTime date, TimeOfDay time) {
    final combinedDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return formatter.format(combinedDateTime.toUtc());
  }

  _touchEveryField() {
    final title = StandarText.dirty(state.title.value);
    final description = StandarText.dirty(state.description.value);
    final price = StandarPrice.dirty(state.price.value);
    state = state.copyWith(
        title: title,
        isFormPosted: true,
        description: description,
        price: price,
        isValid: Formz.validate([title, description, price]));
  }
}
