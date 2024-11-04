import 'package:fixnow/presentation/widgets/login/login_actions.dart';
import 'package:fixnow/presentation/widgets/login/login_button_form.dart';
import 'package:fixnow/presentation/widgets/login/login_footer_button.dart';
import 'package:fixnow/presentation/widgets/login/login_form.dart';
import 'package:fixnow/presentation/widgets/login/login_header.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.width / 460;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleFactor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60 * scaleFactor),
              LoginHeader(scaleFactor: scaleFactor),

              SizedBox(height: 40 * scaleFactor),
              LoginForm(scaleFactor: scaleFactor),

              SizedBox(height: 20 * scaleFactor),
              LoginButtonForm(scaleFactor: scaleFactor),

              SizedBox(height: 40 * scaleFactor),
              LoginActions(scaleFactor: scaleFactor),

              SizedBox(height: 90 * scaleFactor),
              LoginFooterButton(scaleFactor: scaleFactor),
            ],
          ),
        ),
      ),
    );
  }
}