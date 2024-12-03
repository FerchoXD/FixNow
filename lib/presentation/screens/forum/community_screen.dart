import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  showMessage(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      backgroundColor: const Color.fromARGB(255, 255, 229, 227),
      textColor: Colors.red.shade300,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    ref.listen(forumProvider, (previous, next) {
      if (next.message.isEmpty) return;
      showMessage(context, next.message);
    });

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SegmentedButton(
                segments: const [
                  ButtonSegment(value: ForumOption.all, icon: Text('Publicaciones'),),
                  ButtonSegment(value: ForumOption.myPost, icon: Text('Mis publicaciones')),
                ],
                selected:  <ForumOption>{forumState.forumOption},
                onSelectionChanged: (value) {
                  ref.read(forumProvider.notifier).updateOption(value.first);
                },
              ),
            )
          ],
        ));
  }
}

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumState = ref.watch(forumProvider);

    return ListView.builder(
      itemCount: forumState.myListPost.length,
      itemBuilder: (context, index) {
        final post = forumState.myListPost[index];
        return ForumPost(
          username: post.username,
          tittle: post.title,
          content: post.content,
        );
      },
    );
  }
}
