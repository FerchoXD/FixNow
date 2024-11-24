import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';

class ScheduleServiceTwo extends StatelessWidget {
  const ScheduleServiceTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agendar servicio'),
      ),
      body: ScheduleServiceTwoView(),
    );
  }
}

class ScheduleServiceTwoView extends StatelessWidget {
  const ScheduleServiceTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Despues de enviar la solicitud deberás esperar que el proveedor confirme el servicio.'),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              label: 'Título del servicio',
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              label: 'Proveedor',
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              label: 'Proveedor',
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              label: 'Descripción del servicio',
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              label: 'Título del servicio',
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              label: 'Precio acordado',
            ),
            SizedBox(
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
                  onPressed: () {},
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
