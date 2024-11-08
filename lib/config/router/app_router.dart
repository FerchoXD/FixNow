import 'package:fixnow/config/router/app_router_notifier.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterUserScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/activate',
        builder: (context, state) => const ActivateScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

     if (isGoingTo == '/' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/') {
          return '/home';
        }
      }

      if(authStatus == AuthStatus.newUserRegistred) {
        if(isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/' ) {
          return '/activate';
        }
      }

      if(authStatus == AuthStatus.accountActivated) {
         if(isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/' || isGoingTo == '/activate' ) {
          return '/home';
        }
      }


      return null;
    },
  );
});
