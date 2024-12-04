import 'package:fixnow/domain/entities/total_transactions.dart';
import 'package:fixnow/infrastructure/datasources/finances_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final financeProvider =
    StateNotifierProvider<FinanceNotifier, FinanceState>((ref) {
  final financesData = FinancesData();
  final authData = ref.watch(authProvider);
  return FinanceNotifier(financesData: financesData, authData: authData);
});

class FinanceState {
  final TotalTransactions? totalTransactions;
  final bool isLoading;
  final String message;
  final List<TotalTransactions>? listTotalTransactions;
  const FinanceState(
      {this.totalTransactions,
      this.isLoading = false,
      this.listTotalTransactions,
      this.message = ''});

  FinanceState copyWith({
    TotalTransactions? totalTransactions,
    bool? isLoading,
    List<TotalTransactions>? listTotalTransactions,
    String? message,
  }) =>
      FinanceState(
          totalTransactions: totalTransactions ?? this.totalTransactions,
          isLoading: isLoading ?? this.isLoading,
          listTotalTransactions:
              listTotalTransactions ?? this.listTotalTransactions,
          message: message ?? this.message);
}

class FinanceNotifier extends StateNotifier<FinanceState> {
  final FinancesData financesData;
  final AuthState authData;
  FinanceNotifier({required this.financesData, required this.authData})
      : super(const FinanceState()) {
        getTotalTransactionsByUser();
    // getCurrentMonthTransactions();
  }

  Future<void> getTotalTransactionsByUser() async {
    try {
      state = state.copyWith(isLoading: true);
      final listTotalTransactionsByUser =
          await financesData.getTotalTransactionsByUser(authData.user!.id!);
      state = state.copyWith(
          listTotalTransactions: listTotalTransactionsByUser, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(
          listTotalTransactions: null, isLoading: false, message: e.message);
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> getTotalTransactions(String year, String month) async {
    try {
      state = state.copyWith(isLoading: true);
      final totalTransactions = await financesData.getTotalTransactions(
          authData.user!.id!, year, month);
      state = state.copyWith(totalTransactions: totalTransactions);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Error();
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> getCurrentMonthTransactions() async {
    DateTime currentMonth = DateTime.now();

    try {
      state = state.copyWith(isLoading: true);
      final totalTransactions = await financesData.getTotalTransactions(
          authData.user!.id!,
          currentMonth.year.toString(),
          currentMonth.month.toString());

      state = state.copyWith(totalTransactions: totalTransactions);
    } on CustomError catch (e) {
      state = state.copyWith(
          isLoading: false, totalTransactions: null, message: e.message);
    }
    state = state.copyWith(isLoading: false);
  }
}
