import 'package:fixnow/presentation/widgets/register/register_actions.dart';
import 'package:fixnow/presentation/widgets/register/register_button_form.dart';
import 'package:fixnow/presentation/widgets/register/register_footer_button.dart';
import 'package:fixnow/presentation/widgets/register/register_form.dart';
import 'package:fixnow/presentation/widgets/register/register_header.dart';
import 'package:flutter/material.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.width / 460;
    final tipoUsuario = ModalRoute.of(context)!.settings.arguments as String? ?? 'cliente';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleFactor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20 * scaleFactor),
              RegisterHeader(scaleFactor: scaleFactor),
              SizedBox(height: 20 * scaleFactor),
              RegisterForm(scaleFactor: scaleFactor),
              SizedBox(height: 40 * scaleFactor),
              RegisterButtonForm(scaleFactor: scaleFactor, tipoUsuario: tipoUsuario),
              SizedBox(height: 20 * scaleFactor),
              RegisterActions(scaleFactor: scaleFactor),
              SizedBox(height: 20 * scaleFactor),
              RegisterFooterButton(scaleFactor: scaleFactor),
            ],
          ),
        ),
      ),
    );
  }
}
