import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsProvider = StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier();
});

class NotificationsState {
  final AuthorizationStatus status;
  final List<dynamic> notifications;

  const NotificationsState(
      {this.status = AuthorizationStatus.notDetermined,
      this.notifications = const []});

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<dynamic>? notifications,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
      );
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationsNotifier() : super(NotificationsState()) {
    requestPermission();
    getFirebaseMessaginToken();
    onForegroundMessage();
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
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification == null) return;
    print('Message also contained a notification: ${message.notification}');
  }

  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }
}
