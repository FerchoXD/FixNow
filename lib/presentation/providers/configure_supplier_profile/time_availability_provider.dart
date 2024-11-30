import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = StateNotifierProvider<TimeNotifier, TimeState>((ref) {
  final supplierData = ProfileSupplierData();

  return TimeNotifier(supplierData: supplierData, ref: ref);
});

class TimeState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final List<Map<String, dynamic>> schedule;
  final bool isCompleted;

  const TimeState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.schedule = const [],
      this.isCompleted = false,});

  TimeState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    List<Map<String, dynamic>>? schedule,
    bool? isCompleted,
  }) =>
      TimeState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          schedule: schedule ?? this.schedule,
          isCompleted: isCompleted ?? this.isCompleted,);
}

class TimeNotifier extends StateNotifier<TimeState> {
  final ProfileSupplierData supplierData;
  final Ref ref;
  TimeNotifier({required this.supplierData, required this.ref}) : super(const TimeState());

  onScheduleChanged(List<Map<String, dynamic>> schedule) {
    state = state.copyWith(schedule: schedule);
  }

  onFormSubmit(String id) async {
    state = state.copyWith(isPosting: true);

    try {
      final supplier = await supplierData.sendCalendar(id, state.schedule);
      state = state.copyWith(isCompleted: true);
      ref.read(authProvider.notifier).setUserCustomerOrSupplier(supplier);
    } catch (e) {
      throw Error();
    }
    state = state.copyWith(isPosting: false);
  }
}
