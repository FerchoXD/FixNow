import 'package:flutter/material.dart';

class HistoryModalView extends StatelessWidget {
  final String title;
  final String description;
  final String createdAt;
  const HistoryModalView(
      {super.key,
      required this.title,
      required this.description,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Detalles de servicio',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.primary),
            ),
            const SizedBox(height: 20),
            Text(title),
            Text(description),
            Text(createdAt),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Rechazar',
                    style: TextStyle(color: Colors.red.shade300),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.red.withOpacity(0.1))),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.blue.shade300),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.blue.withOpacity(0.1))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
