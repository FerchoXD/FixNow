import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';

class TokenData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future sendTokenFCM(String userId, String tokenFCM) async {
    try {
      final response = await dio.post('/auth/tokenfcm', data: {
        "tokenfcm": tokenFCM,
        "userUuid": userId,
      });
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
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
