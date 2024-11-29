import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends ConsumerWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
      case 3:
        context.go('/home/3');
        break;
      case 4:
        context.go('/home/4');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GNav(
        tabActiveBorder: Border.all(color: colors.primary, width: 0.2),
        tabBackgroundColor: colors.secondary,
        gap: 8,
        activeColor: colors.primary,
        color: colors.onSurfaceVariant,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Inicio',
          ),
          GButton(
            icon: Icons.comment,
            text: 'Comunidad',
          ),
          GButton(
            icon: Icons.assistant,
            text: 'Asistente',
          ),
          GButton(
            icon: authState.user!.role == 'CUSTOMER' ? Icons.notifications : Icons.attach_money_rounded,
            text: authState.user!.role == 'CUSTOMER' ? 'Notificaciones' : 'Finanzas',
          ),
          GButton(
            icon: Icons.person,
            text: 'Perfil',
          ),
        ],
        selectedIndex: currentIndex,
        onTabChange: (value) {
          onItemTapped(context, value);
        },
      ),
    );
  }
}

