import 'package:fixnow/domain/entities/push_message.dart';
import 'package:fixnow/presentation/providers/notifications/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsServiceHistory extends ConsumerWidget {
  final String serviceId;

  const DetailsServiceHistory({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.read(notificationsProvider.notifier).getMessageByServiceId(serviceId);
    return Scaffold(
      appBar: AppBar(),
      body: (message != null) ? _DetailsView(message: message) : const Center(child: Text('La notificación no existe'),),
    );
  }
}

class _DetailsView extends StatelessWidget {

  final PushMessage message;

  const _DetailsView({ required this.message });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [

          if ( message.imageUrl != null ) 
            Image.network(message.imageUrl!),

          const SizedBox( height: 30 ),

          Text( message.title, style: textStyles.titleMedium ),
          Text( message.body ),

          const Divider(),
          Text( message.data.toString()),

        ],
      ),
    );
  }
}