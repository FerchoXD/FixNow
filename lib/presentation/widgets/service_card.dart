import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String iconPath;
  final String label;

  const ServiceCard({super.key, required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,),
          height: 80,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(iconPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(label),
      ],
    );
  }
}