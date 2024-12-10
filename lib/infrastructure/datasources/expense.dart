import 'package:intl/intl.dart';

class Expense {
  final String id;
  final String type;
  final double amount;
  final DateTime date;
  final String category;
  final String description;

  Expense({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.category,
    required this.description,
  });

  static List<Expense> fromJson(List<Map<String, dynamic>> jsonData) {
    return jsonData.map((e) => Expense(
      id: e["_id"],
      type: e["type"],
      amount: e["amount"].toDouble(),
      date: DateTime.parse(e["date"]),
      category: e["category"],
      description: e["description"],
    )).toList();
  }
}

Map<String, double> groupExpensesByDate(List<Expense> expenses) {
  Map<String, double> grouped = {};

  for (var expense in expenses) {
    String dateKey = DateFormat('yyyy-MM-dd').format(expense.date); // Formatear la fecha
    if (!grouped.containsKey(dateKey)) {
      grouped[dateKey] = 0.0;
    }
    if (expense.type == 'expense') {
      grouped[dateKey] = grouped[dateKey]! + expense.amount;
    }
  }

  return grouped;
}
