import 'package:flutter/material.dart';

class BasicInformationAnimatedProgressBar extends StatelessWidget {
  final PageController pageController;
  final int totalSteps;

  const BasicInformationAnimatedProgressBar({
    super.key,
    required this.pageController,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: pageController,
            builder: (context, _) {
              // Solo acceder a page si el controlador tiene clientes
              double progressValue = pageController.hasClients
                  ? (pageController.page ?? 0) / (totalSteps - 1)
                  : 0.0;

              return LinearProgressIndicator(
                value: progressValue.clamp(0.0, 1.0), // Limita entre 0 y 1
                backgroundColor: Color.fromARGB(255, 124, 204, 250),
                color: Color.fromARGB(255, 23, 109, 201),
              );
            },
          ),
        ),
        SizedBox(width: 10),
        Text(
          pageController.hasClients
              ? "${((pageController.page ?? 0) / (totalSteps - 1) * 100).toInt()}%"
              : "0%", // Muestra 0% si no tiene clientes
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
