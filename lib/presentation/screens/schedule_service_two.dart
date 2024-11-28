import 'package:dio/dio.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';

class ScheduleServiceTwo extends StatelessWidget {
  const ScheduleServiceTwo({super.key});

  Future<void> _postServiceData(BuildContext context, DateTime agreedDate) async {
    final dio = Dio();
    const url = 'https://69fa-2806-262-3404-9c-7910-4ceb-d179-5618.ngrok-free.app/api/v1/history/create/service';

    final payload = {
      "userUuid": "1c63052d-6b63-4d48-a45c-75c956154326",
      "title": "Mantenimiento general",
      "description": "Revisión y reparación de equipos.",
      "agreedPrice": 150.01,
      "agreedDate": agreedDate.toUtc().toIso8601String(),
    };

    try {
      final response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Servicio agendado con éxito.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.data['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agendar el servicio: $e')),
      );
    }
  }

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
