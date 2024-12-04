import 'package:fixnow/domain/entities/chat_message.dart';
import 'package:flutter/material.dart';

class MeMessage extends StatelessWidget {
  final ChatMessage message;
  const MeMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    message.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor: colors.primary.withOpacity(0.2),
              radius: 20,
              child: Icon(Icons.person, color: colors.primary.withOpacity(0.6)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
