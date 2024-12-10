class MonthlyData {
  final String month;
  final double totalExpenses;

  MonthlyData({required this.month, required this.totalExpenses});
}

List<MonthlyData> parseData(List<Map<String, dynamic>> rawData) {
  List<String> months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  return rawData.map((data) {
    return MonthlyData(
      month: months[data['month'] - 1],
      totalExpenses: data['totalExpenses'].toDouble(),
    );
  }).toList();
}