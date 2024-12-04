import 'package:fixnow/domain/entities/message.dart';
import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssistanScreen extends StatelessWidget {
  const AssistanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatViewAssitant(),
    );
  }
}

class ChatViewAssitant extends ConsumerWidget {
  const ChatViewAssitant({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(assistantProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: chatState.isLoadingChat
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller:
                        ref.read(assistantProvider.notifier).chatScrollController,
                    itemCount: chatState.messageList.length +
                        (chatState.isWritingBot ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (chatState.isWritingBot &&
                          index == chatState.messageList.length) {
                        return const LoadingMessage();
                      }

                      final message = chatState.messageList[index];
                      return (message.fromWho == FromWho.gemini)
                          ? GeminiMessageBubble(message: message)
                          : MessageBubble(message: message);
                    },
                  ),
          ),
          const MessageField(),
        ],
      ),
    );
  }
}
