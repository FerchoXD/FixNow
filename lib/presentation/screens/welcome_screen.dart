import 'package:fixnow/presentation/widgets/home/welcome_footer_buton.dart';
import 'package:fixnow/presentation/widgets/home/welcome_actions.dart';
import 'package:fixnow/presentation/widgets/home/welcome_header.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.width / 460;

    return Scaffold(
      backgroundColor: const Color(0xFF4C98E9),
      body: Padding( 
        padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            WelcomeHeader(scaleFactor: scaleFactor),

            SizedBox(height: 40 * scaleFactor),
            WelcomeActions(scaleFactor: scaleFactor),
            
            const Spacer(),
            WelcomeFooterButon(scaleFactor: scaleFactor)
          ],
        ),
      ),
    );
  }
}
