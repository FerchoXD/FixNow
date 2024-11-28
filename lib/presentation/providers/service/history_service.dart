import 'package:dio/dio.dart';

class HistoryService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://69fa-2806-262-3404-9c-7910-4ceb-d179-5618.ngrok-free.app/api/v1/history',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
    validateStatus: (status) {
      return status != null && status >= 200 && status <= 404;
    },
  ));

  Future<Map<String, dynamic>> fetchHistory(String userUuid) async {
    try {
      final response = await _dio.post(
        '/get/history',
        data: {'userUuid': userUuid},
      );

      if (response.statusCode == 200 && response.data != null) {
        return {
          'status': 200,
          'data': response.data['data'] ?? [],
          'message': response.data['message'] ?? '',
        };
      } else if (response.statusCode == 404) {
        return {
          'status': 404,
          'message': response.data['message'] ?? 'No se encontraron registros.',
        };
      } else {
        return {
          'status': response.statusCode,
          'message': response.data['message'] ?? 'Error desconocido.',
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
