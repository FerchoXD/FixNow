import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = StateNotifierProvider<TimeNotifier, TimeState>((ref) {
  final supplierData = ProfileSupplierData();
  return TimeNotifier(
    supplierData: supplierData
  );
});

class TimeState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final List<Map<String, dynamic>> schedule;

  const TimeState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.schedule = const []});

  TimeState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    List<Map<String, dynamic>>? schedule,
  }) =>
      TimeState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        schedule: schedule ?? this.schedule,
      );
}

class TimeNotifier extends StateNotifier<TimeState> {
  final ProfileSupplierData supplierData;
  TimeNotifier({required this.supplierData}) : super(const TimeState());

  onScheduleChanged(List<Map<String, dynamic>> schedule) {
    state = state.copyWith(schedule: schedule);
  }

  onFormSubmit(String id) async {
    try {
      await supplierData.sendCalendar(id, state.schedule);
    } catch (e) {
      throw Error();
    }
    state = state.copyWith(isPosting: true);
    state = state.copyWith(isPosting: false);
  }
}
