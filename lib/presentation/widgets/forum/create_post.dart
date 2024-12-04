import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePost extends ConsumerWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authStatus = ref.watch(authProvider);
    final forumState = ref.watch(forumProvider);
    return AlertDialog(
      backgroundColor: colors.surface,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Crear publicación',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Titulo de publicación',
                  onChanged:
                      ref.read(forumProvider.notifier).onChangedTitlePost,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  maxLines: 5,
                  label: 'Escribe aquí...',
                  keyboardType: TextInputType.multiline,
                  onChanged:
                      ref.read(forumProvider.notifier).onChangedContentPost,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(colors.primary.value),
                      foregroundColor: Color(colors.onPrimary.value),
                    ),
                    onPressed: forumState.isPosting
                        ? null
                        : () {
                            ref
                                .read(forumProvider.notifier)
                                .createPost(authStatus.user!.fullname!, authStatus.user!.id!);
                            Navigator.pop(context);
                          },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
