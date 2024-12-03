import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnow/domain/entities/push_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier();
});

class NotificationsState {
  final AuthorizationStatus status;
  final List<PushMessage> notifications;

  const NotificationsState(
      {this.status = AuthorizationStatus.notDetermined,
      this.notifications = const []});

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
      );
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationsNotifier() : super(const NotificationsState()) {
    requestPermission();
    getFirebaseMessaginToken();
    _onForegroundMessage();
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    state = state.copyWith(status: settings.authorizationStatus);
  }

  void getFirebaseMessaginToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);

    state =
        state.copyWith(notifications: [notification, ...state.notifications]);
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

 PushMessage? getMessageByServiceId(String serviceId) {
  final exist = state.notifications.any(
    (element) => element.data!['serviceId'] == serviceId,
  );
  if (!exist) return null;

  return state.notifications.firstWhere(
    (element) => element.data!['serviceId'] == serviceId,
  );
}

}
