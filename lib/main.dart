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
        '/specialities' : (context) => const SpecialitiesScreen(),
        '/basic_information' : (context) => const BasicInformationScreen(),
        '/select_service' : (context) => const SelectServiceScreen(),
        '/work_experience' : (context) => const WorkExperienceScreen(),
        '/pricing' : (context) => const PricingScreen(),
        '/schedules' : (context) => const SchedulesScreen(),
        '/photo_gallery' : (context) => const PhotoGalleryScreen(),
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixNow',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: _screens,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Screen404(),
        );
      },
    );
  }
}