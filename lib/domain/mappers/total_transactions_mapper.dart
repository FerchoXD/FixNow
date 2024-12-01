import 'package:fixnow/domain/entities/total_transactions.dart';

class TotalTransactionsMapper {
  static TotalTransactions totalTransactionsToEntity(
          Map<String, dynamic> json) =>
      TotalTransactions(
        id: json["_id"],
        userId: json["userId"],
        balance: (json['balance'] as num).toDouble(),
        year: json["year"] as int,
        month: json["month"] as int,
        totalIncome: (json['totalIncome'] as num).toDouble(),
        totalExpenses: (json['totalExpenses'] as num).toDouble(),
      );
}
