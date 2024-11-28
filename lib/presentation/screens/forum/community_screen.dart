import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: _CommunityView(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            child: FloatingActionButton.extended(
              heroTag: 'newPost',
              backgroundColor: colors.primary,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const CreatePost();
                    });
              },
              label: const Text('Publicación'),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityView extends ConsumerWidget {
  const _CommunityView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumState = ref.watch(forumProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: forumState.listPost.length,
        itemBuilder: (context, index) {
          final post = forumState.listPost[index];
          return ForumPost(
            username: post.username,
            tittle: post.title,
            content: post.content,
          );
        },
      ),
    );
  }
}
