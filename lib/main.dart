import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnow/config/constants/environment.dart';
import 'package:fixnow/config/router/app_router.dart';
import 'package:fixnow/config/themes/light_theme.dart';
import 'package:fixnow/firebase_options.dart';
import 'package:fixnow/infrastructure/services/firebase_messaging.dart';
import 'package:fixnow/presentation/providers/notifications/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Environment.initEnvironment();
  await initializeDateFormatting('es');
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      builder: (context, child) =>
          HandleNotificationInteractions(child: child!),
    );
  }
}

class HandleNotificationInteractions extends ConsumerStatefulWidget {
  final Widget child;
  const HandleNotificationInteractions({super.key, required this.child});

  @override
  HandleNotificationInteractionsState createState() =>
      HandleNotificationInteractionsState();
}

class HandleNotificationInteractionsState
    extends ConsumerState<HandleNotificationInteractions> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    ref.read(notificationsProvider.notifier).handleRemoteMessage(message);

    

    // if(message.data['type'] == 'service') {
    //   final serviceId = message.data['serviceId'];
    //   ref.read(goRouterProvider).push('/details-service/$serviceId');
    // }

    if(message.data['type'] == 'chat') {
      ref.read(goRouterProvider).push('/chat');
    }

  }

  @override
  void initState() {
    super.initState();

    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
