import 'package:fixnow/presentation/providers/raiting/raiting_provider.dart';
import 'package:fixnow/presentation/widgets/custom_text_fiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReviewModal extends ConsumerWidget {
  final String supplierId;
  const ReviewModal({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final raitingState = ref.watch(raitingProvider);

    ref.listen(raitingProvider, (previous, next) {
      if (next.reviewPosted) {
        context.pop();
      }
    });

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Escribe una reseña',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.primary),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint:
                  '¿El servicio cumplió con tus expectativas? Déjanos tu opinión.',
              maxLines: 8,
              onChanged: ref.read(raitingProvider.notifier).onReviewChanged,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: raitingState.isSendinReview
                    ? null
                    : () {
                        ref.read(raitingProvider.notifier).sendReview(supplierId);
                      },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
