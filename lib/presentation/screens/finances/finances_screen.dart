import 'package:fixnow/domain/entities/total_transactions.dart';
import 'package:fixnow/presentation/providers/finances/finances_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financesState = ref.watch(financeProvider);
    return financesState.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                BalanceSection(
                  lisTotalTransactions:
                      financesState.listTotalTransactions ?? [],
                ),
                SizedBox(
                  height: 20,
                ),
                ExpenseEvolutionChart(
                  sortedTransactions: financesState.listTotalTransactions ?? [],
                )
              ],
            ),
          );
  }
}

class BalanceSection extends ConsumerStatefulWidget {
  final List<TotalTransactions> lisTotalTransactions;

  const BalanceSection({Key? key, required this.lisTotalTransactions})
      : super(key: key);

  @override
  BalanceSectionState createState() => BalanceSectionState();
}

class BalanceSectionState extends ConsumerState<BalanceSection> {
  late int currentIndex;
  late List<TotalTransactions> sortedTransactions;

  @override
  void initState() {
    super.initState();

    // Ordenar las transacciones por año y mes.
    sortedTransactions = List.from(widget.lisTotalTransactions)
      ..sort((a, b) {
        if (a.year == b.year) {
          return a.month.compareTo(b.month);
        }
        return a.year.compareTo(b.year);
      });

    // Inicializar el índice con el mes actual si está presente, de lo contrario, usar el primero disponible.
    final now = DateTime.now();
    currentIndex = sortedTransactions.indexWhere(
      (transaction) =>
          transaction.year == now.year && transaction.month == now.month,
    );
    if (currentIndex == -1) {
      currentIndex = 0; // Si no se encuentra el mes actual, mostrar el primero.
    }
  }

  @override
  Widget build(BuildContext context) {
    const List<String> meses = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];

    final colors = Theme.of(context).colorScheme;

    if (sortedTransactions.isEmpty) {
      return const Center(
        child: Text('Aún no se han generado transacciones'),
      );
    }

    final currentTransaction = sortedTransactions[currentIndex];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: currentIndex > 0
                    ? () {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    : null,
              ),
              Text(
                "${meses[currentTransaction.month - 1]} ${currentTransaction.year}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: currentIndex < sortedTransactions.length - 1
                    ? () {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBalanceInfo("Inicial", "\$0.00", false),
              _buildBalanceInfo(
                "Balance",
                "\$${currentTransaction.balance.toStringAsFixed(2)}",
                true,
              ),
              _buildBalanceInfo(
                "Gastos",
                "\$${currentTransaction.totalExpenses.toStringAsFixed(2)}",
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceInfo(String title, String value, bool isBold) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

Widget _buildBalanceInfo(String label, String amount, bool isChecked) {
  return Column(
    children: [
      Row(
        children: [
          (isChecked)
              ? const Icon(Icons.check_circle, size: 16, color: Colors.white)
              : const Icon(Icons.radio_button_unchecked,
                  size: 16, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
      const SizedBox(height: 4),
      (isChecked)
          ? Text(
              amount,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            )
          : Text(
              amount,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
    ],
  );
}

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}

class ExpenseEvolutionChart extends StatelessWidget {
  final List<TotalTransactions> sortedTransactions;

  const ExpenseEvolutionChart({super.key, required this.sortedTransactions});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Convertir los datos en FlSpot
    final spots = sortedTransactions.asMap().entries.map((entry) {
      final index = entry.key;
      final transaction = entry.value;
      return FlSpot(index.toDouble(), transaction.totalExpenses.toDouble());
    }).toList();

    // Calcular el cambio en gastos
    String changeText = "Sin datos suficientes para comparar";
    if (spots.length >= 2) {
      final lastExpense = spots[spots.length - 1].y;
      final previousExpense = spots[spots.length - 2].y;
      final difference = lastExpense - previousExpense;
      changeText = difference > 0
          ? "Usted gastó \$${difference.toStringAsFixed(2)} más que en el período anterior"
          : "Usted gastó \$${difference.abs().toStringAsFixed(2)} menos que en el período anterior";
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(4, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Evolución de los gastos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 1000),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                      show: true, border: Border.all(color: Colors.grey)),
                  lineBarsData: [
                    LineChartBarData(
                      color: colors.primary,
                      spots: spots,
                      isCurved: true,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              changeText,
              style: TextStyle(color: colors.primary, fontSize: 16),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Ver",
                style: TextStyle(color: colors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CashFlowChart extends StatelessWidget {
  const CashFlowChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Flujo de caja",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                      show: true, border: Border.all(color: Colors.grey)),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                            toY: 6002,
                            color: colors.primary.withOpacity(0.6),
                            width: 50,
                            borderRadius: BorderRadius.zero),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                            toY: 3020,
                            color: Colors.red.withOpacity(0.6),
                            width: 50,
                            borderRadius: BorderRadius.zero),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                            toY: 2982,
                            color: Colors.green.withOpacity(0.6),
                            width: 50,
                            borderRadius: BorderRadius.zero),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
