import 'dart:io';
import 'package:dio/dio.dart';

class ServiceSupplier {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://f1ee-2806-10ae-f-9d7-dde7-793b-64ef-d4a5.ngrok-free.app',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) {
        return status != null && status >= 200 && status <= 404;
      },
    ),
  );

  // Método fetchSuppliers ajustado
  Future<Map<String, dynamic>> fetchSuppliers(String data) async {
    print("data${data}");
    try {
      final response = await _dio.post(
        '/api/v1/auth/all/suppliers',
        data: {'data': data}, // Ajusta el body si el backend requiere cambios
      );

      print('Respuesta completa: ${response}');

      if (response.statusCode == 200 && response.data != null) {
        // Dado que el servidor devuelve una lista directamente
        final List<dynamic> suppliers = response.data;

        return {
          'status': 200,
          'data': suppliers.map((e) => Map<String, dynamic>.from(e)).toList(),
        };
      } else if (response.statusCode == 404) {
        return {
          'status': 404,
          'message': 'No se encontraron registros.',
        };
      } else {
        return {
          'status': response.statusCode,
          'message': 'Error desconocido.',
        };
      }
    } catch (e) {
      return {
        'status': 500,
        'message': 'Error interno del servidor.',
        'error': e.toString(),
      };
    }
  }
}