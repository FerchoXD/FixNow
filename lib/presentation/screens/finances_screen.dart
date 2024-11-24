import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Asegúrate de agregar esta librería en pubspec.yaml para gráficos.

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Saldo y barra de progreso
              BalanceSection(),
              const SizedBox(height: 20),
              // Gráfico de evolución de los gastos
              ExpenseEvolutionChart(),
              const SizedBox(height: 20),
              // Gráfico de flujo de caja
              CashFlowChart(),
            ],
          ),
        ),
      ),
    );
  }
}

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Saldo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  "\$2,982.00",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.6, // Ejemplo de progreso, puedes cambiarlo dinámicamente
              backgroundColor: colors.surfaceContainer,
              color: colors.primary,
              
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Inicial: \$0.00"),
                Text("Previsto: \$2,982.00"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseEvolutionChart extends StatelessWidget {
  const ExpenseEvolutionChart({super.key});

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
              "Evolución de los gastos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                      show: true, border: Border.all(color: Colors.grey)),
                  lineBarsData: [
                    LineChartBarData(
                      color: colors.primary,
                      spots: [
                        FlSpot(0, 2000),
                        FlSpot(1, 3000),
                        FlSpot(2, 3200),
                        FlSpot(3, 2800),
                        FlSpot(4, 2900),
                        FlSpot(5, 3100),
                      ],
                      isCurved: true,
                      barWidth: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Usted gastó \$3,020.00 más que en la semana anterior",
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
                          borderRadius: BorderRadius.zero
                        ),
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
                          borderRadius: BorderRadius.zero
                        ),
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
                          borderRadius: BorderRadius.zero
                        ),
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
