import 'package:fixnow/Screens/login_screen.dart';
import 'package:fixnow/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 
  final PageController _pageController = PageController(); 
  final List<Widget> _screens = [
    const WelcomeScreen(),
    const LoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // Cambia la página en el PageView
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController, // Asigna el controlador al PageView
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index; // Actualiza el índice al deslizar entre páginas
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Mantén el índice sincronizado
        onTap: _onItemTapped, // Llama al método cuando se toca un ítem
        elevation: 0,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Welcome',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Libera el controlador cuando no es necesario
    super.dispose();
  }
}
