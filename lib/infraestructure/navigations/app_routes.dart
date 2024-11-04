import 'package:flutter/material.dart';
import '../../presentation/screens/index.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> screens = {
    '/': (context) => const WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterUserScreen(),
    '/404': (context) => const Screen404(),
    '/specialities': (context) => const SpecialitiesScreen(),
    '/basic_information': (context) => const BasicInformationScreen(),
    '/select_service': (context) => const SelectServiceScreen(),
    '/work_experience': (context) => const WorkExperienceScreen(),
    '/pricing': (context) => const PricingScreen(),
    '/schedules': (context) => const SchedulesScreen(),
    '/photo_gallery': (context) => const PhotoGalleryScreen(),
    '/home': (context) => const HomeScreen(),
    '/chat': (context) => const ChatScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const Screen404(),
    );
  }
}
