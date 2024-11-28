import 'package:fixnow/config/router/app_router_notifier.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/screens.dart';
import 'package:fixnow/presentation/screens/supplier/configure_profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/configure/information',
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
        path: '/home/:page',
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return HomeScreen(pageIndex: int.parse(pageIndex));
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const ScheduleService(),
      ),
      GoRoute(
          path: '/user/select',
          builder: (context, state) => const UserSelect()),
      GoRoute(
        path: '/profile/supplier',
        builder: (context, state) => const ProfileSuplier(),
      ),
      GoRoute(
        path: '/schedule/2',
        builder: (context, state) => const ScheduleServiceTwo(),
      ),
      GoRoute(
        path: '/configure/information',
        builder: (context, state) => const ConfigureProfileScreen(),
      ),
      GoRoute(
        path: '/configure',
        builder: (context, state) => const ScheduleServiceTwo(),
      ),
      
    ],
    redirect: (context, state) {
      // final isGoingTo = state.matchedLocation;
      // final authStatus = goRouterNotifier.authStatus;
      // final user = goRouterNotifier.user;

      // if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
      //   return null;
      // }

      // if (authStatus == AuthStatus.notAuthenticated) {
      //   if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/user/select') return null;

      //   return '/login';
      // }

      // if (authStatus == AuthStatus.authenticated) {
      //   if (isGoingTo == '/login' ||
      //       isGoingTo == '/register' ||
      //       isGoingTo == '/' || isGoingTo == '/splash') {
      //     return '/home/0';
      //   }
      // }

      // if (authStatus == AuthStatus.newUserRegistred) {
      //   if (isGoingTo == '/login' ||
      //       isGoingTo == '/register' ||
      //       isGoingTo == '/') {
      //     return '/activate';
      //   }
      // }

      // if (authStatus == AuthStatus.accountActivated) {
      //   if (isGoingTo == '/login' ||
      //       isGoingTo == '/register' ||
      //       isGoingTo == '/' ||
      //       isGoingTo == '/activate') {

      //         if(user != null && user.role == 'SUPPLIER' && isGoingTo == '/configure/information') {
                
      //         }

      //     // return '/home/0';
      //   }
      // }

      // return null;
    },
  );
});
