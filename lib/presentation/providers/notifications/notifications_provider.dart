import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnow/domain/entities/push_message.dart';
import 'package:fixnow/infrastructure/datasources/token_data.dart';
import 'package:fixnow/infrastructure/services/key_value_storage.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  final tokenData = TokenData();
  final authState = AuthState();
  final KeyValueStorage keyValueStorage = KeyValueStorage();
  return NotificationsNotifier(
      tokenData: tokenData,
      authState: authState,
      keyValueStorage: keyValueStorage);
});

class NotificationsState {
  final AuthorizationStatus status;
  final List<PushMessage> notifications;
  final String token;

  const NotificationsState(
      {this.status = AuthorizationStatus.notDetermined,
      this.notifications = const [],
      this.token = ''});

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
    String? token,
  }) =>
      NotificationsState(
          status: status ?? this.status,
          notifications: notifications ?? this.notifications,
          token: token ?? this.token);
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final TokenData tokenData;
  final AuthState authState;
  final KeyValueStorage keyValueStorage;
  NotificationsNotifier(
      {required this.tokenData,
      required this.authState,
      required this.keyValueStorage})
      : super(const NotificationsState()) {
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
    await keyValueStorage.setValueKey('fcm_token', token ?? '');
    state = state.copyWith(token: token);
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

// 
