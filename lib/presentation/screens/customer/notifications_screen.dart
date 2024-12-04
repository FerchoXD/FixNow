import 'package:fixnow/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationsView(),
    );
  }
}

class NotificationsView extends ConsumerWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final notificationsState = ref.watch(notificationsProvider);
    return ListView.builder(
        itemCount: notificationsState.notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notificationsState.notifications[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.body),
            leading: notification.imageUrl != null
                ? Image.network(notification.imageUrl!)
                : null,
          );
        });
  }
}
