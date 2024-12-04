import 'package:fixnow/domain/entities/message.dart';
import 'package:flutter/material.dart';

class GeminiMessageBubble extends StatelessWidget {
  final Message message;
  const GeminiMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.assistant,
              color: colors.primary,
              size: 40,
            ),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  message.text,
                  style: TextStyle(color: colors.primary),
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
