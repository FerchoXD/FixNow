import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:fixnow/presentation/providers/chat/chat_provider.dart';
import 'package:fixnow/presentation/widgets/chat/chat_message_field.dart';
import 'package:fixnow/presentation/widgets/chat/loading_message.dart';
import 'package:fixnow/presentation/widgets/chat/me_message.dart';
import 'package:fixnow/presentation/widgets/chat/message_bubble.dart';
import 'package:fixnow/presentation/widgets/chat/message_field.dart';
import 'package:fixnow/presentation/widgets/chat/you_message_bubble.dart';
import 'package:fixnow/presentation/widgets/custom_text_fiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  const ChatScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: ChatView(),
    );
  }
}

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: !chatState.isConnected
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller:
                        ref.read(chatProvider.notifier).chatScrollController,
                    itemCount: chatState.messages.length +
                        (chatState.isWritingYou ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (chatState.isWritingYou &&
                          index == chatState.message.length) {
                        return const LoadingMessage();
                      }

                      final message = chatState.messages[index];
                      return (message.userChat == UserChat.userYou)
                          ? YouMessageBubble(message: message)
                          : MeMessage(message: message);
                    },
                  ),
          ),
          const ChatMessasgeField(),
        ],
      ),
    );
  }
}
