import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final authState = ref.watch(authProvider);
  return ChatNotifier(authState: authState);
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

  ChatNotifier({required this.authState})
      : super(ChatState(messages: [], isConnected: false)) {
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('ws://192.168.1.129:4000',
        IO.OptionBuilder().setTransports(['websocket']).build());

    socket.on('connect', (_) {
      print('Conectado al servidor');
      state = state.copyWith(isConnected: true);
      socket.emit('register', authState.user!.id);
    });

    socket.on('receive-message', (data) {
      print('Mensaje recibido de ${data['senderId']}: ${data['message']}');
    });

    socket.on('disconnect', (_) {
      print('Desconectado del servidor');
    });
  }

  sendMessage(String message, String senderUuid, String receivedUuid) {
    if (message.isEmpty) return;
    final messageData = {
      'senderUuid': authState.user!.id!,
      'receiverUuid': receivedUuid, 
      'message': message 
    };
    print('${senderUuid}, ${receivedUuid}');
    socket.emit('send-message', messageData);
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
