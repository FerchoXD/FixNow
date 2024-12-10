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
  final List<Map<String, dynamic>> listTransactions;
  final bool isTransactionCreated;
  final bool isSendingTransaction;
  final String typeTransaction;
  final double amount;
  final String category;
  final String description;
  const FinanceState(
      {this.totalTransactions,
      this.isLoading = false,
      this.listTotalTransactions,
      this.message = '',
      this.listTransactions = const [],
      this.isTransactionCreated = false,
      this.isSendingTransaction = false,
      this.typeTransaction = 'income',
      this.amount = 0,
      this.category = '',
      this.description = ''});

  FinanceState copyWith(
          {TotalTransactions? totalTransactions,
          bool? isLoading,
          List<TotalTransactions>? listTotalTransactions,
          String? message,
          List<Map<String, dynamic>>? listTransactions,
          bool? isTransactionCreated,
          bool? isSendingTransaction,
          String? typeTransaction,
          double? amount,
          String? category,
          String? description}) =>
      FinanceState(
          totalTransactions: totalTransactions ?? this.totalTransactions,
          isLoading: isLoading ?? this.isLoading,
          listTotalTransactions:
              listTotalTransactions ?? this.listTotalTransactions,
          message: message ?? this.message,
          listTransactions: listTransactions ?? this.listTransactions,
          isTransactionCreated:
              isTransactionCreated ?? this.isTransactionCreated,
          isSendingTransaction:
              isSendingTransaction ?? this.isSendingTransaction,
          typeTransaction: typeTransaction ?? this.typeTransaction,
          amount: amount ?? this.amount,
          category: category ?? this.category,
          description: description ?? this.description);
}

class FinanceNotifier extends StateNotifier<FinanceState> {
  final FinancesData financesData;
  final AuthState authData;
  FinanceNotifier({required this.financesData, required this.authData})
      : super(const FinanceState()) {
    getTotalTransactionsByUser();
    getTransactions();
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

  Future<void> getTransactions() async {
    try {
      final transactions =
          await financesData.getTransactionsByUserId(authData.user!.id!);
      state = state.copyWith(listTransactions: transactions);
    } on CustomError catch (e) {
      state = state.copyWith(
          isLoading: false, listTransactions: [], message: e.message);
    }
  }

  onAmountChanged(double value) {
    state = state.copyWith(amount: value);
  }

  onCategoryChanged(String value) {
    state = state.copyWith(category: value);
  }

  onDescriptionChanged(String value) {
    state = state.copyWith(description: value);
  }

  Future<void> createTransaction() async {
    final date = DateTime.now().toIso8601String().split('T').first;
    print(date);
    try {
      state = state.copyWith(isSendingTransaction: true);
      final newTransaction = await financesData.createTransaction(
          state.typeTransaction,
          state.amount,
          date,
          state.category,
          authData.user!.id!,
          state.description);
      state = state.copyWith(
          isTransactionCreated: true, isSendingTransaction: false);
    } on CustomError catch (e) {
      state = state.copyWith(
          isTransactionCreated: false, isSendingTransaction: false);
    }
    Future.delayed(const Duration(seconds: 3), () {
      state = state.copyWith(
          isTransactionCreated: false, isSendingTransaction: false);
    });
  }

  updateOption(String value) {
    state = state.copyWith(typeTransaction: value);
  }
}
