import 'package:fixnow/domain/entities/total_transactions.dart';
import 'package:fixnow/infrastructure/datasources/finances_data.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final financeProvider = StateNotifierProvider<FinanceNotifier, FinanceState>((ref) {
  final financesData = FinancesData();
  final authData = ref.watch(authProvider);
  return FinanceNotifier(financesData: financesData, authData: authData);
});

class FinanceState {
  final TotalTransactions? totalTransactions;
  final bool isLoading;
  const FinanceState({this.totalTransactions, this.isLoading = false});

  FinanceState copyWith({
    TotalTransactions? totalTransactions,
    bool? isLoading,
  }) =>
      FinanceState(
          totalTransactions: totalTransactions ?? this.totalTransactions,
          isLoading: isLoading ?? this.isLoading);
}

class FinanceNotifier extends StateNotifier<FinanceState> {
  final FinancesData financesData;
  final AuthState authData;
  FinanceNotifier({required this.financesData, required this.authData})
      : super(const FinanceState()) {
    getCurrentMonthTransactions();
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
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Error();
    }
    state = state.copyWith(isLoading: false);
  }
}
