import 'package:fixnow/presentation/providers/finances/finances_provider.dart';
import 'package:fixnow/presentation/widgets/custom_text_fiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateTransactionModal extends ConsumerWidget {
  const CreateTransactionModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final financeState = ref.watch(financeProvider);

    ref.listen(financeProvider, (previous, next) {
      if (next.isTransactionCreated) {
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
              'Crear transaccion',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.primary),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton(
                  segments: const [
                    ButtonSegment(
                      value: 'income',
                      icon: Text(
                        'Ingreso',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ButtonSegment(
                      value: 'expense',
                      icon: Text(
                        'Gasto',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                  selected: <String>{financeState.typeTransaction},
                  onSelectionChanged: (value) {
                    ref
                        .read(financeProvider.notifier)
                        .updateOption(value.first);
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Cantidad',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final parsedValue = double.tryParse(value) ?? 0.0;
                ref.read(financeProvider.notifier).onAmountChanged(parsedValue);
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Categoria',
              onChanged: ref.read(financeProvider.notifier).onCategoryChanged,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Descripción',
              onChanged:
                  ref.read(financeProvider.notifier).onDescriptionChanged,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: financeState.isSendingTransaction
                    ? null
                    : () {
                        ref.read(financeProvider.notifier).createTransaction();
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
