import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';

class CustomerData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<String> createSercie(String userId, String supplierId, String title, String description,
      double agreedPrice, String agreedDate) async {
        print('Customer id: $userId Supplier ID: $supplierId');
    try {
      final response = await dio.post('/history/create/service', data: {
        "customerUuid": userId,
        "supplierUuid": supplierId,
        "title": title,
        "description": description,
        "agreedPrice": agreedPrice,
        "agreedDate": agreedDate,
      });

      final successMessage = response.data['message'];
      return successMessage;

    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(e.response?.data['message'] ?? 'Error al enviar datos');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }
}
