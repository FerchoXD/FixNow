import 'package:fixnow/domain/entities/total_transactions.dart';
import 'package:fixnow/presentation/providers/finances/finances_provider.dart';
import 'package:fixnow/presentation/widgets/create_transaction.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financesState = ref.watch(financeProvider);
    final colors = Theme.of(context).colorScheme;

    Future<void> _refreshData() async {
      await ref.read(financeProvider.notifier).getTotalTransactionsByUser();
    }

    showMessage(BuildContext context, String message) {
      Fluttertoast.showToast(
        msg: message,
        fontSize: 16,
        backgroundColor: const Color.fromARGB(255, 241, 255, 243),
        textColor: Colors.green.shade300,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    ref.listen(financeProvider, (previous, next) {
      if (!next.isTransactionCreated) return;
      showMessage(context, 'Transacción creada');
    });

    void _showReviewModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Permite que el modal se ajuste al teclado
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Espacio dinámico según el teclado
            ),
            child: const CreateTransactionModal(),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            backgroundColor: colors.primary,
            onPressed: () {
              _showReviewModal(context);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: financesState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    BalanceSection(
                      lisTotalTransactions:
                          financesState.listTotalTransactions ?? [],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'La siguiente gráfica muestra la evolución de tus gastos a lo largo de los meses.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: colors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Evolución de gastos'),
                    ExpensesChart(
                      listTotalTransactions:
                          financesState.listTotalTransactions ?? [],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'La siguiente gráfica muestra la evolución de tus ingresos a lo largo de los meses.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: colors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Evolución de ingresos'),
                    IncomeChart(
                      listTotalTransactions:
                          financesState.listTotalTransactions ?? [],
                    )
                  ],
                ),
              ),
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
                  fontSize: 24,
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
              _buildBalanceInfo(
                  "Ingresos", "\$${currentTransaction.totalIncome}", false),
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
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            fontSize: 24,
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

class ExpensesChart extends StatelessWidget {
  final List<TotalTransactions> listTotalTransactions;

  const ExpensesChart({super.key, required this.listTotalTransactions});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final sortedData = listTotalTransactions
      ..sort((a, b) => a.month.compareTo(b.month));

    final List<FlSpot> spots = sortedData
        .map((entry) {
          final month = entry.month.toDouble();
          final totalExpenses = entry.totalExpenses.toDouble();

          if (month.isFinite && totalExpenses.isFinite) {
            return FlSpot(month, totalExpenses);
          } else {
            return null; // Si los valores no son válidos, no incluirlos
          }
        })
        .whereType<FlSpot>() // Esta línea elimina los valores nulos de la lista
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    // Asegúrate de que el valor es válido antes de generar la etiqueta
                    if (value.isFinite) {
                      // Mostrar todos los meses en el eje X
                      switch (value.toInt()) {
                        case 1:
                          return Text('Ene');
                        case 2:
                          return Text('Feb');
                        case 3:
                          return Text('Mar');
                        case 4:
                          return Text('Abr');
                        case 5:
                          return Text('May');
                        case 6:
                          return Text('Jun');
                        case 7:
                          return Text('Jul');
                        case 8:
                          return Text('Ago');
                        case 9:
                          return Text('Sep');
                        case 10:
                          return Text('Oct');
                        case 11:
                          return Text('Nov');
                        case 12:
                          return Text('Dic');
                        default:
                          return Text('');
                      }
                    }
                    return const Text(
                        ''); // Retorna texto vacío si el valor no es válido
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: const Color(0xFFEF6258),
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                    show: true,
                    color: const Color(0xFFEF6258).withOpacity(0.1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncomeChart extends StatelessWidget {
  final List<TotalTransactions> listTotalTransactions;

  const IncomeChart({super.key, required this.listTotalTransactions});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final sortedData = listTotalTransactions
      ..sort((a, b) => a.month.compareTo(b.month));

    final List<FlSpot> spots = sortedData
        .map((entry) {
          final month = entry.month.toDouble();
          final totalIncome = entry.totalIncome.toDouble();

          if (month.isFinite && totalIncome.isFinite) {
            return FlSpot(month, totalIncome);
          } else {
            return null; // Si los valores no son válidos, no incluirlos
          }
        })
        .whereType<FlSpot>() // Esta línea elimina los valores nulos de la lista
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    // Asegúrate de que el valor es válido antes de generar la etiqueta
                    if (value.isFinite) {
                      // Mostrar todos los meses en el eje X
                      switch (value.toInt()) {
                        case 1:
                          return Text('Ene');
                        case 2:
                          return Text('Feb');
                        case 3:
                          return Text('Mar');
                        case 4:
                          return Text('Abr');
                        case 5:
                          return Text('May');
                        case 6:
                          return Text('Jun');
                        case 7:
                          return Text('Jul');
                        case 8:
                          return Text('Ago');
                        case 9:
                          return Text('Sep');
                        case 10:
                          return Text('Oct');
                        case 11:
                          return Text('Nov');
                        case 12:
                          return Text('Dic');
                        default:
                          return Text('');
                      }
                    }
                    return const Text(
                        ''); // Retorna texto vacío si el valor no es válido
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.green,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                    show: true, color: Colors.green.withOpacity(0.1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
