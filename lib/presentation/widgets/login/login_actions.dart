import 'package:fixnow/presentation/widgets/social_auth/action_button_facebook.dart';
import 'package:fixnow/presentation/widgets/social_auth/action_button_google.dart';
import 'package:fixnow/presentation/widgets/social_auth/style_button_facebook.dart';
import 'package:fixnow/presentation/widgets/social_auth/style_button_google.dart';
import 'package:fixnow/core/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class LoginActions extends StatelessWidget {
  final double scaleFactor;
  const LoginActions({super.key, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(height: 20 * scaleFactor),
        Text(
          'O conéctate con',
          style: textTheme.textoNegro14(scaleFactor),
        ),
        SizedBox(height: 20 * scaleFactor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyleButtonGoogle.buildButton(scaleFactor, () {
              ActionButtonGoogle.onPressed(context);
            }),
            SizedBox(width: 40 * scaleFactor),
            StyleButtonFacebook.buildButton(scaleFactor, () {
              ActionButtonFacebook.onPressed(context);
            }),
          ],
        ),
      ],
    );
  }
}