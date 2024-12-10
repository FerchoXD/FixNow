import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final chatProvider =
    StateNotifierProvider.family<ChatNotifier, ChatState, String>(
        (ref, supplierId) {
  final authState = ref.watch(authProvider);
  return ChatNotifier(authState: authState, supplierId: supplierId);
});

class ChatState {
  final List<ChatMessage> messages;
  final bool isConnected;
  final String message;
  final bool isWritingYou;
  final String customerId;
  final String supplierId;

  ChatState(
      {required this.messages,
      this.isConnected = false,
      this.message = '',
      this.isWritingYou = false,
      this.customerId = '',
      this.supplierId = ''});

  ChatState copyWith(
          {List<ChatMessage>? messages,
          bool? isConnected,
          String? message,
          bool? isWritingYou,
          String? customerId,
          String? supplierId}) =>
      ChatState(
          messages: messages ?? this.messages,
          isConnected: isConnected ?? this.isConnected,
          message: message ?? this.message,
          isWritingYou: isWritingYou ?? this.isWritingYou,
          customerId: customerId ?? this.customerId,
          supplierId: supplierId ?? this.supplierId);
}

class ChatNotifier extends StateNotifier<ChatState> {
  late IO.Socket socket;
  final AuthState authState;
  final ScrollController chatScrollController = ScrollController();
  final String supplierId;

  ChatNotifier({required this.authState, required this.supplierId})
      : super(ChatState(messages: [], isConnected: false)) {
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('ws://192.168.172.168:5001',
        IO.OptionBuilder().setTransports(['websocket']).build());

    socket.on('connect', (_) {
      print('Conectado al servidor');
      state = state.copyWith(isConnected: true);
      socket.emit('register', authState.user!.id);
    });

    socket.on('new_message', (data) {
      print('Nuevo mensaje de ${data['sender']}: ${data['message']}');
      _addMessageOther(data['message']);
    });

    socket.on('error', (data) {
      print(data['message']);
    });

    socket.on('disconnect', (_) {
      print('Desconectado del servidor');
    });
  }

  sendMessage(String message, String clientId, String supplierId) {
    if (message.isEmpty) return;
    final messageData = {
      "sender": clientId,
      "receiver": supplierId,
      "message": message,
      "name": authState.user!.fullname
    };
    socket.emit('send_message', messageData);
    _addMessage(message);
  }

  void _addMessageOther(String message) {
    final newMessage = ChatMessage(text: message, userChat: UserChat.userYou);
    state = state.copyWith(messages: [...state.messages, newMessage]);
  }

  void _addMessage(String message) {
    final newMessage = ChatMessage(text: message, userChat: UserChat.userMe);
    state = state.copyWith(messages: [...state.messages, newMessage]);
  }

  void disconnect() {
    socket.disconnect();
  }
}
