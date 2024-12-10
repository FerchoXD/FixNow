import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/providers/chat/chat_provider.dart';
import 'package:fixnow/presentation/widgets/chat/chat_message_field.dart';
import 'package:fixnow/presentation/widgets/chat/loading_message.dart';
import 'package:fixnow/presentation/widgets/chat/me_message.dart';
import 'package:fixnow/presentation/widgets/chat/you_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatSupplier extends ConsumerWidget {
  final String customerId;
  final String name;
  const ChatSupplier({super.key, required this.customerId, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: ChatView(
        customerId: customerId ,
      ),
    );
  }
}

class ChatView extends ConsumerWidget {
  final String customerId;
  const ChatView({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatSupplierProvider);
    final userState = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: !chatState.isConnected
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller:
                        ref.read(chatSupplierProvider.notifier).chatScrollController,
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
          ChatMessasgeField(supplierId: userState.user!.id!, customerId: customerId, whoIsSendMessage: userState.user!.role!,),
        ],
      ),
    );
  }
}
