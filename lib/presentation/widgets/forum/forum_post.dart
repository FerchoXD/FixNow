import 'package:fixnow/presentation/providers/forum/forum_provider.dart';
import 'package:fixnow/presentation/widgets/custom_text_fiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumPost extends ConsumerWidget {
  final String username;
  final String tittle;
  final String content;
  final String postId;

  const ForumPost({
    super.key,
    required this.username,
    required this.tittle,
    required this.content,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumState = ref.watch(forumProvider);
    final colors = Theme.of(context).colorScheme;

    void _showCommentsModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true, // Esto permite controlar el tamaño del modal
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Ajusta por el teclado
              ),
              child: forumState.isLoadingComments
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 2,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Comentarios',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colors.primary),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: forumState.listComments.isEmpty
                                ? SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Center(
                                      child: Text('Aún no hay comentarios'),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: forumState.listComments.length,
                                    itemBuilder: (context, index) {
                                      final comment =
                                          forumState.listComments[index];

                                      return ListTile(
                                        title: Text('${comment['username']}'),
                                        subtitle: Text('${comment['content']}'),
                                      );
                                    },
                                  ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                hint: 'Escribe un comentario',
                              )),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.send, color: colors.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                  onPressed: () {},
                  child: const Text('Post'),
                ),
                TextButton(
                  onPressed: () {
                    print(postId);
                    ref.read(forumProvider.notifier).getComments(postId);
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
