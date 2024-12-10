import 'package:fixnow/domain/entities/message.dart';
import 'package:fixnow/infrastructure/datasources/assitant_data.dart';
import 'package:fixnow/infrastructure/datasources/message_with_providers.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fixnow/infrastructure/services/data_history_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final assistantProvider =
    StateNotifierProvider<AsistantNotifier, AsistantState>((ref) {
  final authState = ref.watch(authProvider);
  final assistanData = AssitantData();
  return AsistantNotifier(authState: authState, assistantData: assistanData);
});

class AsistantState {
  final List messageList;
  final bool isConnected;
  final bool isLoadingChat;
  final bool isWritingBot;

  AsistantState({
    this.messageList = const [],
    this.isConnected = false,
    this.isLoadingChat = false,
    this.isWritingBot = false,
  });

  AsistantState copyWith({
    List? messageList,
    bool? isConnected,
    bool? isLoadingChat,
    bool? isWritingBot,
  }) =>
      AsistantState(
        messageList: messageList ?? this.messageList,
        isConnected: isConnected ?? this.isConnected,
        isLoadingChat: isLoadingChat ?? this.isLoadingChat,
        isWritingBot: isWritingBot ?? this.isWritingBot,
      );
}

class AsistantNotifier extends StateNotifier<AsistantState> {
  final ScrollController chatScrollController = ScrollController();
  late GenerativeModel chatModel;
  final AuthState authState;
  final AssitantData assistantData;

  AsistantNotifier({required this.authState, required this.assistantData})
      : super(AsistantState()) {
    // loadConversation();
    // _startListeningToConnectivity();
  }

  // void _startListeningToConnectivity() {
  //   Connectivity().onConnectivityChanged.listen((connectivityResult) {
  //     updateConnectionStatus(connectivityResult);
  //   });
  // }

  // void updateConnectionStatus(ConnectivityResult result) {
  //   bool connected = result != ConnectivityResult.none;
  //   state = state.copyWith(isConnected: connected);
  // }

  Future<void> geminiMessage(text) async {
    final newMessageGemini = Message(text: text, fromWho: FromWho.gemini);
    state =
        state.copyWith(messageList: [...state.messageList, newMessageGemini]);
    moveScrollToBottom();
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    state = state.copyWith(
      messageList: [...state.messageList, newMessage],
    );

    moveScrollToBottom();
    geminiResponse(text);
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  // Future<void> loadConversation() async {
  //   // final listMessages = await dataHistoryService.loadConversation();
  //   if (listMessages != null) {
  //     List<Message> restoredMessages = listMessages.map((msgStr) {
  //       var msg = jsonDecode(msgStr);
  //       return Message(
  //         text: msg['text'],
  //         fromWho: msg['fromWho'] == 'me' ? FromWho.me : FromWho.gemini,
  //       );
  //     }).toList();
  //     state = state.copyWith(messageList: restoredMessages);
  //   }
  //   for (var message in state.messageList) {
  //     if (message.fromWho == FromWho.me) {
  //       history.add(Content.text(message.text));
  //     } else {
  //       history.add(Content.model([TextPart(message.text)]));
  //     }
  //   }

  //   state = state.copyWith(isLoadingChat: false);
  //   moveScrollToBottom();
  // }

  Future<void> geminiResponse(String text) async {
    state = state.copyWith(isWritingBot: true);

    try {
      final message = await assistantData.getRecomendation(authState.user!.id!, text);

      if (message is String) {
        simpleResponse(message);
      } else if (message.containsKey('complexResponse')) {
        complexResponse(
            message['complexResponse'], message['suppliers']['suppliers']);
      } else if (message.containsKey('simpleResponse')) {
        simpleResponse(message['simpleResponse']);
      } else {}
    } on CustomError catch (e) {
      print(e);
    }

    state = state.copyWith(isWritingBot: false);
  }

  void complexResponse(String complexResponse, List suppliers) {
    final geminiMessage = MessageWithProviders(
      text: complexResponse,
      suppliers: suppliers,
      fromWho: FromWho.gemini,
    );

    state = state.copyWith(
      messageList: [...state.messageList, geminiMessage],
    );
  }

  void simpleResponse(String simpleResponse) {
    final geminiMessage =
        Message(text: simpleResponse, fromWho: FromWho.gemini);
    state = state.copyWith(messageList: [...state.messageList, geminiMessage]);
  }

  // Future<void> newConversation() async {
  //   state = state.copyWith(messageList: [], isLoadingChat: true);
  //   history.clear();
  //   history.add(Content.text(
  //       "Eres un asistente que responde exclusivamente sobre servicios de mantenimiento y reparaciones del hogar."));
  //   await dataHistoryService.clearConversation();
  //   state = state.copyWith(isLoadingChat: false);
  // }
}
