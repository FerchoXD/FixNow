// import 'package:fixnow/presentation/providers/finances/finances_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart'; // Asegúrate de agregar esta librería en pubspec.yaml para gráficos.

// class FinanceScreen extends ConsumerWidget {
//   const FinanceScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final financesState = ref.watch(financeProvider);
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: const Column(
//         children: [BalanceSection()],
//       ),
//     );
//   }
// }

// class BalanceSection extends ConsumerWidget {
//   const BalanceSection({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     const List<String> meses = [
//       'Enero',
//       'Febrero',
//       'Marzo',
//       'Abril',
//       'Mayo',
//       'Junio',
//       'Julio',
//       'Agosto',
//       'Septiembre',
//       'Octubre',
//       'Noviembre',
//       'Diciembre'
//     ];
    

//     final colors = Theme.of(context).colorScheme;
//     final financeState = ref.watch(financeProvider);
//     String mesActual = meses[financeState.totalTransactions!.month - 1];
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       decoration: BoxDecoration(
//           color: colors.primary, borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//                 onPressed: () {
                 
//                 },
//               ),
//               Text(
//                 mesActual,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.arrow_forward, color: Colors.white),
//                 onPressed: () {
                 
//                 },
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildBalanceInfo("Inicial", "\$0.00", false),
//               _buildBalanceInfo("Balance",
//                   "\$${financeState.totalTransactions!.balance}", true),
//               _buildBalanceInfo("Gastos",
//                   "\$${financeState.totalTransactions!.totalExpenses}", false),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBalanceInfo(String label, String amount, bool isChecked) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             (isChecked)
//                 ? const Icon(Icons.check_circle, size: 16, color: Colors.white)
//                 : const Icon(Icons.radio_button_unchecked,
//                     size: 16, color: Colors.white),
//             const SizedBox(width: 5),
//             Text(
//               label,
//               style: const TextStyle(color: Colors.white, fontSize: 14),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         (isChecked)
//             ? Text(
//                 amount,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold),
//               )
//             : Text(
//                 amount,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500),
//               ),
//       ],
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() {
//     return this[0].toUpperCase() + substring(1);
//   }
// }

// // class ExpenseEvolutionChart extends StatelessWidget {
// //   const ExpenseEvolutionChart({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final colors = Theme.of(context).colorScheme;
// //     return Card(
// //       elevation: 5,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               "Evolución de los gastos",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
// //             ),
// //             const SizedBox(height: 10),
// //             SizedBox(
// //               height: 200,
// //               child: LineChart(
// //                 LineChartData(
// //                   gridData: FlGridData(show: false),
// //                   titlesData: FlTitlesData(show: false),
// //                   borderData: FlBorderData(
// //                       show: true, border: Border.all(color: Colors.grey)),
// //                   lineBarsData: [
// //                     LineChartBarData(
// //                       color: colors.primary,
// //                       spots: [
// //                         FlSpot(0, 2000),
// //                         FlSpot(1, 3000),
// //                         FlSpot(2, 3200),
// //                         FlSpot(3, 2800),
// //                         FlSpot(4, 2900),
// //                         FlSpot(5, 3100),
// //                       ],
// //                       isCurved: true,
// //                       barWidth: 3,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               "Usted gastó \$3,020.00 más que en la semana anterior",
// //               style: TextStyle(color: colors.primary, fontSize: 16),
// //             ),
// //             TextButton(
// //               onPressed: () {},
// //               child: Text(
// //                 "Ver",
// //                 style: TextStyle(color: colors.primary),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class CashFlowChart extends StatelessWidget {
// //   const CashFlowChart({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final colors = Theme.of(context).colorScheme;
// //     return Card(
// //       elevation: 5,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               "Flujo de caja",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
// //             ),
// //             const SizedBox(height: 10),
// //             SizedBox(
// //               height: 200,
// //               child: BarChart(
// //                 BarChartData(
// //                   alignment: BarChartAlignment.spaceAround,
// //                   gridData: FlGridData(show: false),
// //                   titlesData: FlTitlesData(show: false),
// //                   borderData: FlBorderData(
// //                       show: true, border: Border.all(color: Colors.grey)),
// //                   barGroups: [
// //                     BarChartGroupData(
// //                       x: 0,
// //                       barsSpace: 4,
// //                       barRods: [
// //                         BarChartRodData(
// //                             toY: 6002,
// //                             color: colors.primary.withOpacity(0.6),
// //                             width: 50,
// //                             borderRadius: BorderRadius.zero),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 1,
// //                       barsSpace: 4,
// //                       barRods: [
// //                         BarChartRodData(
// //                             toY: 3020,
// //                             color: Colors.red.withOpacity(0.6),
// //                             width: 50,
// //                             borderRadius: BorderRadius.zero),
// //                       ],
// //                     ),
// //                     BarChartGroupData(
// //                       x: 2,
// //                       barsSpace: 4,
// //                       barRods: [
// //                         BarChartRodData(
// //                             toY: 2982,
// //                             color: Colors.green.withOpacity(0.6),
// //                             width: 50,
// //                             borderRadius: BorderRadius.zero),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
