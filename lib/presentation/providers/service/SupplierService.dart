import 'package:dio/dio.dart';

class SupplierService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://5051-2806-262-3404-9c-342b-4c1a-df3a-a5d1.ngrok-free.app/api/v1/auth',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<List<dynamic>> fetchSuppliers(String prompt, String token) async {
    _dio.options.headers['Authorization'] = token;
    try {
      final response = await _dio.post(
        '/suppliers',
        data: {'prompt': prompt},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return response.data['suppliers'] ?? [];
      } else {
        throw Exception('Error al obtener proveedores: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}
