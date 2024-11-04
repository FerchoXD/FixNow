import 'package:fixnow/presentation/widgets/configure_supplier_profile/specialities/instructions.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/specialities/skip_button.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/specialities/speciality_header.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/specialities/start_button.dart';
import 'package:flutter/material.dart';

class SpecialitiesScreen extends StatelessWidget {
  const SpecialitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaleFactor = MediaQuery.of(context).size.width / 460;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpecialityHeader( scaleFactor: scaleFactor),
            SizedBox(height: 20 * scaleFactor),
            Instructions( scaleFactor: scaleFactor),
            SizedBox(height: 20 * scaleFactor),
            StartButton( scaleFactor: scaleFactor),
            SizedBox(height: 20 * scaleFactor),
            SkipButton( scaleFactor: scaleFactor),
          ],
        ),
      ),
    );
  }
}
