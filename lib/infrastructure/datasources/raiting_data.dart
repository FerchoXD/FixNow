import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';

class RaitingData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future createReview(String userId, String review) async {
    try {
      final response = await dio.post('/raiting/create/comment', data: {
        "userUuid": userId,
        "content": review,
      });

      if (response.statusCode == 200) {
        final data = {'message': response.data['message'], 'status': '200'};
        return data;
      }

      if (response.statusCode == 201) {
        final data = {'message': response.data['message'], 'status': '201'};
        return data;
      }
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

  Future getReviews(String userId) async {
    try {
      final response = await dio.post('/raiting/comments', data: {"userUuid": userId});

      final List<Map<String, dynamic>> reviews = [];
      for (final review in response.data['comentarios'] ?? []) {
        reviews.add(review);
      }
      return reviews;
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
