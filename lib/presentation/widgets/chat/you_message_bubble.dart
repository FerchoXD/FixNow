import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:fixnow/domain/entities/message.dart';
import 'package:flutter/material.dart';

class YouMessageBubble extends StatelessWidget {
  final ChatMessage message;
  const YouMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: colors.primary.withOpacity(0.2),
            radius: 20,
            child: Icon(Icons.person, color: colors.primary.withOpacity(0.6)),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  message.text,
                  style: TextStyle(color: colors.onSurface),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
