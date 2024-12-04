import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumPost extends ConsumerWidget {
  final String username;
  final String tittle;
  final String content;

  const ForumPost({
    super.key,
    required this.username,
    required this.tittle,
    required this.content,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    void _showCommentsModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Comentarios',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          10, // Número de comentarios (puedes reemplazar con tus datos)
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Comentario $index'),
                          subtitle:
                              const Text('Este es un comentario de ejemplo.'),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Escribe un comentario...',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Lógica para enviar el comentario
                          Navigator.pop(context); // Cierra la ventana modal
                        },
                        icon: Icon(Icons.send, color: colors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
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
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              tittle,
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
                  onPressed: () {
                    // Lógica para publicar
                  },
                  child: const Text('Post'),
                ),
                TextButton(
                  onPressed: () {
                    _showCommentsModal(context);
                  },
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
