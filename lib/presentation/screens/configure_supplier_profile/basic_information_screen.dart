import 'package:fixnow/presentation/widgets/configure_supplier_profile/basic_information/basic_information_animated_progress_bar.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/basic_information/basic_information_continue_button.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/basic_information/basic_infromation_inputs_form.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/basic_information/basic_information_text_instruccion.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/basic_information/basic_infromation_title.dart';
import 'package:flutter/material.dart';

class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({super.key});

  @override
  _BasicInformationScreenState createState() => _BasicInformationScreenState();
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.width / 460;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleFactor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40 * scaleFactor),
              BasicInformationTitle( scaleFactor: scaleFactor),
              SizedBox(height: 10 * scaleFactor),
              BasicInformationTextInstruccion( scaleFactor: scaleFactor),
              SizedBox(height: 20 * scaleFactor),
              BasicInformationAnimatedProgressBar(
                pageController: _pageController,
                totalSteps: 1,
              ),
              SizedBox(height: 20 * scaleFactor),
              BasicInformationInputsForm(scaleFactor: scaleFactor),
              SizedBox(height: 20 * scaleFactor),
              BasicInformationContinueButton(scaleFactor: scaleFactor),
            ],
          ),
        ),
      ),
    );
  }
}

