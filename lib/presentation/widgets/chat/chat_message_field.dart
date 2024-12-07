import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/providers/chat/chat_provider.dart';
import 'package:fixnow/presentation/providers/supplier/supplier_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessasgeField extends ConsumerWidget {
  final String supplierId;
  final String customerId;
  final String whoIsSendMessage;
  const ChatMessasgeField(
      {super.key,
      required this.supplierId,
      required this.customerId,
      required this.whoIsSendMessage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final chatState = ref.watch(assistantProvider);
    final textController = TextEditingController();
    final focusNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Escribe aquí...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.primary,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15.5)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(113, 48, 48, 48),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.5)),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              whoIsSendMessage == 'CUSTOMER'
                  ? ref
                      .read(chatProvider.notifier)
                      .sendMessage(textController.text, customerId, supplierId)
                  : ref
                      .read(chatProvider.notifier)
                      .sendMessage(textController.text, supplierId, customerId);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
              backgroundColor: colors.primary,
            ),
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
