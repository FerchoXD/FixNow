import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/providers/service/schedule_service_provider.dart';
import 'package:fixnow/presentation/widgets/custom_text_fiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ScheduleServiceTwo extends ConsumerStatefulWidget {
  final String supplierId;

  const ScheduleServiceTwo({super.key, required this.supplierId});

  @override
  ScheduleServiceTwoState createState() => ScheduleServiceTwoState();
}

class ScheduleServiceTwoState extends ConsumerState<ScheduleServiceTwo> {
  @override
  Widget build(BuildContext context) {
   

    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: const Color(0xFFE9FFE9),
        textColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

     ref.listen(scheduleServiceProvider, (previous, next) {
      if (next.successMessage.isNotEmpty) {
        showToast(next.successMessage);
        context.go('/home/0');
      }
    });

    final colors = Theme.of(context).colorScheme;
    final authStatus = ref.watch(authProvider);
    final scheduleState = ref.watch(scheduleServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agendar servicio',
          style: TextStyle(color: colors.primary),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Completa los detalles del serivicio',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              label: 'Titulo de servicio',
              onChanged:
                  ref.read(scheduleServiceProvider.notifier).onTitleChanged,
              errorMessage: scheduleState.isFormPosted
                  ? scheduleState.title.errorMessage
                  : null,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Descripción',
              onChanged: ref
                  .read(scheduleServiceProvider.notifier)
                  .onDescriptionChanged,
              errorMessage: scheduleState.isFormPosted
                  ? scheduleState.description.errorMessage
                  : null,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Precio acordado',
              keyboardType: TextInputType.number,
              errorMessage: scheduleState.isFormPosted
                  ? scheduleState.price.errorMessage
                  : null,
              onChanged: (value) {
                final parsedValue = double.tryParse(value) ?? 0.0;
                ref
                    .read(scheduleServiceProvider.notifier)
                    .onPriceChanged(parsedValue);
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    ref
                        .read(scheduleServiceProvider.notifier)
                        .onFormSubmit(authStatus.user!.id!, widget.supplierId);
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
        ),
      ),
    );
  }
}
