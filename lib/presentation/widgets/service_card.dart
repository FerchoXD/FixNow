import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final IconData iconService;
  final String label;
  final bool isSelected;

  const ServiceCard({
    super.key,
    required this.iconService,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: colors.primary, width: 0.1),
        borderRadius: BorderRadius.circular(15),
        color: isSelected ? colors.primary : colors.secondary
      ),
      child: Column(
        children: [
          Icon(iconService, size: 60, color: isSelected ? Colors.white : colors.primary.withOpacity(0.8)),
          const SizedBox(
              height: 10), 
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : colors.primary.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
