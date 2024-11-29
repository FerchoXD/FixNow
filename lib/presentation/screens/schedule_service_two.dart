import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScheduleServiceTwo extends StatefulWidget {
  final String selectedDateTime;

  const ScheduleServiceTwo({super.key, required this.selectedDateTime});

  @override
  State<ScheduleServiceTwo> createState() => _ScheduleServiceTwoState();
}

class _ScheduleServiceTwoState extends State<ScheduleServiceTwo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    final dio = Dio();
    const url = 'https://69fa-2806-262-3404-9c-7910-4ceb-d179-5618.ngrok-free.app/api/v1/history/create/service';

    final title = _titleController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text);
    final agreedDate = widget.selectedDateTime;

    print(widget.selectedDateTime);

    if (title.isEmpty || description.isEmpty || price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos.')),
      );
      return;
    }

    final payload = {
      "userUuid": "27181bbb-ed9b-4e79-b46c-a053128fc646",
      "title": _titleController.text,
      "description": _descriptionController.text,
      "agreedPrice": double.tryParse(_priceController.text) ?? 0.0,
      "agreedDate": DateTime.parse(widget.selectedDateTime).toUtc().toIso8601String(),
    };

    try {
      final response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        // Manejar la respuesta exitosa
        GoRouter.of(context).go('/home');
        print('Servicio agendado exitosamente');
      } else {
        // Manejar otros códigos de estado
        print('Error al agendar el servicio: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        // Manejar errores específicos de Dio
        print('Error de Dio: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agendar el servicio: ${e.message}')),
        );
      } else {
        // Manejar otros tipos de errores
        print('Error inesperado: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inesperado al agendar el servicio: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completar detalles'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título del servicio'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio acordado'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
