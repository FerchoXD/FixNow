import 'package:fixnow/infrastructure/datasources/history_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HistoryOption { all, pending, confirmed, done, cancelled }

final historyProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  final historyData = HistoryData();
  final authSate = ref.watch(authProvider);
  return HistoryNotifier(historyData: historyData, authState: authSate);
});

class HistoryState {
  final Map<String, dynamic>? history;
  final String message;
  final String userId;
  final bool isLoading;
  final HistoryOption historyOption;
  final String statusUpdated;
  final bool isStatusUpdated;

  const HistoryState(
      {this.history,
      this.message = '',
      this.userId = '',
      this.isLoading = true,
      this.historyOption = HistoryOption.all,
      this.statusUpdated = '',
      this.isStatusUpdated = false});

  HistoryState copyWith(
          {Map<String, dynamic>? history,
          String? message,
          String? userId,
          bool? isLoading,
          HistoryOption? historyOption,
          String? statusUpdated,
          bool? isStatusUpdated}) =>
      HistoryState(
          history: history ?? this.history,
          message: message ?? this.message,
          userId: userId ?? this.userId,
          isLoading: isLoading ?? this.isLoading,
          historyOption: historyOption ?? this.historyOption,
          statusUpdated: statusUpdated ?? this.statusUpdated,
          isStatusUpdated: isStatusUpdated ?? this.isStatusUpdated);
}

class HistoryNotifier extends StateNotifier<HistoryState> {
  final HistoryData historyData;
  final AuthState authState;
  HistoryNotifier({required this.historyData, required this.authState})
      : super(HistoryState()) {
        getHistory();
      }


  Future<void> getHistory() async {
    try {
      final history = await historyData.getHistory(authState.user!.id!, authState.user!.role!);

      state = state.copyWith(history: history);
      print(state.history);
    } on CustomError catch (e) {
      state = state.copyWith(message: e.message);
    }
    state = state.copyWith(isLoading: false);
  }

  updateOption(HistoryOption value) {
    state = state.copyWith(historyOption: value);
  }

  Future changeStatusService(String serviceUuid, String status) async {
    try {
      final statusChanged =
          await historyData.changeStatusService(serviceUuid, status);
      state =
          state.copyWith(statusUpdated: statusChanged, isStatusUpdated: true);
    } on CustomError catch (e) {
      state = state.copyWith(message: e.message, isStatusUpdated: false);
    }
    Future.delayed(const Duration(seconds: 3), () {
      state = state.copyWith(statusUpdated: '', isStatusUpdated: false);
    });
  }
}
