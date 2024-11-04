import 'package:fixnow/infraestructure/navigations/app_routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixNow',
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: AppRoutes.screens,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
