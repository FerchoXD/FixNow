import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final Icon iconService;
  final String label;

  const ServiceCard({
    super.key,
    required this.iconService,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: colors.primary, width: 0.1),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade200,
        //     blurRadius: 6,
        //     offset: const Offset(0, 4),
        //     spreadRadius: 1,
        //   )
        // ],
        borderRadius: BorderRadius.circular(15),
        // color: colors.primaryContainer,
        color: colors.secondary
      ),
      child: Column(
        children: [
          iconService,
          const SizedBox(
              height: 10), // Espaciado entre el contenedor y el texto
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: colors.primary.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
