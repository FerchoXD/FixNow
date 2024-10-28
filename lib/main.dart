import 'package:flutter/material.dart';

import 'Screens/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _screens = {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register_user': (context) => const RegisterUserScreen(),
        '/404': (context) => const Screen404(),
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixNow',
      debugShowCheckedModeBanner: false,
      initialRoute: '/404',
      routes: _screens,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Screen404(),
        );
      },
    );
  }
}