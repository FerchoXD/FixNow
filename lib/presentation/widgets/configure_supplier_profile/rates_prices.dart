import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatesPrices extends ConsumerWidget {
  const RatesPrices({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final pricesState = ref.watch(pricesProvider);
    final authState = ref.watch(authProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Establece un precio estandar por tus servicios',
            style: TextStyle(fontSize: 16)),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          label: 'Precio estandar',
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final parsedValue = double.tryParse(value) ?? 0.0;
            ref
                .read(pricesProvider.notifier)
                .onStandarPriceChanged(parsedValue);
          },
          errorMessage: pricesState.isFormPosted
              ? pricesState.standarPrice.errorMessage
              : null,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
            'Si tus precios se basan por hora de trabajo, puedes definirlo en el siguiente campo.',
            style: TextStyle(fontSize: 16)),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          label: 'Tarifa por hora',
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final parsedValue = double.tryParse(value) ?? 0.0;
            ref.read(pricesProvider.notifier).onHourlyRateChanged(parsedValue);
          },
          errorMessage: pricesState.isFormPosted
              ? pricesState.hourlyRate.errorMessage
              : null,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Nota: El precio puedes negociarlo después directamente con los clientes.',
          style: TextStyle(
              color: colors.primary, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: pricesState.isPosting ? null : () {
                ref.read(pricesProvider.notifier).onFormSubmit(authState.user!.id!);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 17),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }
}
