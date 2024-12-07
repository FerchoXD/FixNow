import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/providers/chat/chat_provider.dart';
import 'package:fixnow/presentation/providers/supplier/supplier_profile_provider.dart';
import 'package:fixnow/presentation/widgets/chat/chat_message_field.dart';
import 'package:fixnow/presentation/widgets/chat/loading_message.dart';
import 'package:fixnow/presentation/widgets/chat/me_message.dart';
import 'package:fixnow/presentation/widgets/chat/you_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  final String supplierId;
  const ChatScreen({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierState = ref.watch(supplierProfileProvider(supplierId));
    return Scaffold(
      appBar: AppBar(
        title: Text(supplierState.supplier!.firstname),
      ),
      body: ChatView(
        supplierId: supplierId,
      ),
    );
  }
}

class ChatView extends ConsumerWidget {
  final String supplierId;
  const ChatView({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
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
          ChatMessasgeField(
              supplierId: supplierId, customerId: userState.user!.id!, whoIsSendMessage: userState.user!.role!,),
        ],
      ),
    );
  }
}
