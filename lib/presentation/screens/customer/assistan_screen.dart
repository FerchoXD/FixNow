import 'package:fixnow/domain/entities/gemini_complex_response.dart';
import 'package:fixnow/domain/entities/message.dart';
import 'package:fixnow/infrastructure/datasources/message_with_providers.dart';
import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                : chatState.messageList.isEmpty
                    ? const NewAssistan()
                    : ListView.builder(
                        controller: ref
                            .read(assistantProvider.notifier)
                            .chatScrollController,
                        itemCount: chatState.messageList.length +
                            (chatState.isWritingBot ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (chatState.isWritingBot &&
                              index == chatState.messageList.length) {
                            return const LoadingMessage();
                          }

                          final message = chatState.messageList[index];

                          if (message is MessageWithProviders) {
                            return GeminiMessageBubbleWithProviders(
                                message: message);
                          }

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

class NewAssistan extends ConsumerWidget {
  const NewAssistan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/assistant.svg',
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '¡Hola, ${userState.user!.name}!',
          style: TextStyle(fontSize: 36, color: colors.primary),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Estoy aquí para ayudarte a encontrar soluciones rápidas y confiables.',
            style: TextStyle(fontSize: 20, color: colors.onSurface),
          ),
        )
      ],
    );
  }
}
