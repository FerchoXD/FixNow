import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumPost extends ConsumerWidget {
  final String username;
  final String tittle;
  final String content;
  const ForumPost(
      {super.key,
      required this.username,
      required this.tittle,
      required this.content});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colors.primary.withOpacity(0.2),
                  radius: 20,
                  child: Icon(Icons.person,
                      color: colors.primary.withOpacity(0.6)),
                ),
                const SizedBox(width: 10),
                Text(
                  username, // Nombre del autor
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              tittle, // Título de la publicación
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Post'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Comentarios'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
