import 'package:fixnow/presentation/providers/chat/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SupplierChatScreen extends ConsumerWidget {
  const SupplierChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatSupplierProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Chats'),
      ),
      body: ListView.builder(
        itemCount: chatState.listCustomers.length,
        itemBuilder: (context, index) {
          final customer = chatState.listCustomers[index];
          final chatName = customer['name'];
          final customerId = customer['id'];

          return ListTile(
              leading: CircleAvatar(
                backgroundColor: colors.primary,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(chatName ?? 'Cliente'),
              subtitle: Text(
                'Tienes un nuevo mensaje',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                print(chatName);
                context.push(
                  '/chat/customer/$customerId/$chatName',
                );
              });
        },
      ),
    );
  }
}
