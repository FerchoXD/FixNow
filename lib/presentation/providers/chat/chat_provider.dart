import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final authState = AuthState();
  return ChatNotifier(authState: authState);
});

class ChatState {
  final List<ChatMessage> messages;
  final bool isConnected;
  final String message;
  final bool isWritingYou;

  ChatState(
      {required this.messages,
      required this.isConnected,
      this.message = '',
      this.isWritingYou = false});

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isConnected,
    String? message,
    bool? isWritingYou,
  }) =>
      ChatState(
          messages: messages ?? this.messages,
          isConnected: isConnected ?? this.isConnected,
          message: message ?? this.message,
          isWritingYou: isWritingYou ?? this.isWritingYou);
}

class ChatNotifier extends StateNotifier<ChatState> {
  late IO.Socket socket;
  final AuthState authState;
  final ScrollController chatScrollController = ScrollController();

  ChatNotifier({required this.authState})
      : super(ChatState(messages: [], isConnected: false)) {
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('ws://192.168.1.167:4000',
        IO.OptionBuilder().setTransports(['websocket']).build());

    // Conectarse
    socket.on('connect', (_) {
      print('Conectado al servidor');
      // Registrar el usuario con su ID único
      state = state.copyWith(isConnected: true);
      socket.emit('register', authState.user?.id);
    });

    // Escuchar mensajes recibidos
    socket.on('receive-message', (data) {
      print('Mensaje recibido de ${data['senderId']}: ${data['message']}');
    });

    // Manejar desconexión
    socket.on('disconnect', (_) {
      print('Desconectado del servidor');
    });
  }

  sendMessage(String message) {
    if (message.isEmpty) return;
    socket.emit('send-message', message);
    _addMessage(message);
  }

  void _addMessage(String message) {
    final newMessage = ChatMessage(text: message, userChat: UserChat.userMe);
    state = ChatState(
        messages: [...state.messages, newMessage],
        isConnected: state.isConnected);
  }

  void disconnect() {
    socket.disconnect();
  }
}
