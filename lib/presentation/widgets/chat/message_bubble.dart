import 'package:fixnow/domain/entities/message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({super.key, required this.message});

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
                    color: colors.primary,
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
                    style:  const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor: colors.primary,
              radius: 20,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
