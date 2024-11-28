import 'package:fixnow/presentation/widgets/history/history_view.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Historial',
          style: TextStyle(color: colors.primary),
        ),
      ),
      body: const HistoryView(),
    );
  }
}
