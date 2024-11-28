import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = StateNotifierProvider<TimeNotifier, TimeState>((ref) {
  return TimeNotifier();
});

class TimeState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final List<Map<String, dynamic>> schedule;

  const TimeState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.schedule = const []
  });

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
  TimeNotifier():super(const TimeState());

  onScheduleChanged(List<Map<String, dynamic>> schedule) { 
    state = state.copyWith(schedule: schedule);
  }

  onFormSubmit() {
    
  }

}