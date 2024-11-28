import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/screens/home_screen.dart';
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
      backgroundColor: colors.primaryContainer,
      content: Form(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: double.maxFinite),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Crear publicación',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Titulo de publicación',
                onChanged: ref.read(forumProvider.notifier).onChangedTitlePost,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                maxLines: 5,
                label: 'Escribe aquí...',
                keyboardType: TextInputType.multiline,
                onChanged:
                    ref.read(forumProvider.notifier).onChangedContentPost,
                // onChanged: ref.,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Color(colors.primary.value),
                        foregroundColor: Color(colors.onPrimary.value)),
                    onPressed: forumState.isPosting
                        ? null
                        : () {
                            ref
                                .read(forumProvider.notifier)
                                .createPost(authStatus.user!.fullname);
                            if (forumState.isFormPosted) {
                              Navigator.of(context).pop();
                            }
                          },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
