import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';

class HistoryData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<Map<String, dynamic>> getHistory(String userUuid, String role) async {
    final String url;
    final Map data;
    if (role == 'CUSTOMER') {
      url = '/history/get/history/customer';
      data = {'customerUuid': userUuid};
    } else {
      url = '/history/get/history/supplier';
      data = {'supplierUuid': userUuid};
    }
    try {
      final response = await dio.post(
        url,
        data: data,
      );
      return response.data;
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
        throw CustomError(
            e.response?.data['message'] ?? 'Error al obtener datos');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }

  Future changeStatusService() async {
    try {

      final response = await dio.post('/history/status', data: {

      }); 

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
        throw CustomError(
            e.response?.data['message'] ?? 'Error al obtener datos');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }
}
