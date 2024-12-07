import 'package:fixnow/infrastructure/datasources/history_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HistoryOption { all, pending, progress, confirmed, canceled }

final historyProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  final historyData = HistoryData();
  final authSate = AuthState();
  return HistoryNotifier(historyData: historyData, authState: authSate);
});

class HistoryState {
  final Map<String, dynamic>? history;
  final String message;
  final String userId;
  final bool isLoading;
  final HistoryOption historyOption;

  const HistoryState(
      {this.history,
      this.message = '',
      this.userId = '',
      this.isLoading = true,
      this.historyOption = HistoryOption.all});

  HistoryState copyWith({
    Map<String, dynamic>? history,
    String? message,
    String? userId,
    bool? isLoading,
    HistoryOption? historyOption,
  }) =>
      HistoryState(
          history: history ?? this.history,
          message: message ?? this.message,
          userId: userId ?? this.userId,
          isLoading: isLoading ?? this.isLoading,
          historyOption: historyOption ?? this.historyOption);
}

class HistoryNotifier extends StateNotifier<HistoryState> {
  final HistoryData historyData;
  final AuthState authState;
  HistoryNotifier({required this.historyData, required this.authState})
      : super(HistoryState());
  Future<void> getHistory(String userId, String role) async {
    try {
      final history = await historyData.getHistory(userId, role);

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
}
