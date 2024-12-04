import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/total_transactions.dart';
import 'package:fixnow/domain/mappers/total_transactions_mapper.dart';
import 'package:fixnow/infrastructure/errors.dart';

class FinancesData {
  final dio = Dio(BaseOptions(baseUrl: "http://192.168.1.163:3005/api/v1"));

  Future<TotalTransactions> getTotalTransactions(
      String userId, String year, String month) async {
    try {
      final response = await dio.post('/finances/transactions/user',
          data: {"userId": userId, "year": year, "month": month});

      final totalTransaction =
          TotalTransactionsMapper.totalTransactionsToEntity(response.data);
      return totalTransaction;
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

  Future<List<TotalTransactions>> getTotalTransactionsByUser(
      String userId) async {
    try {
      final response = await dio.get(
        '/finances/transactions/user/$userId',
      );

      final List<TotalTransactions> listTotalTransactions = [];
      for (final totalTransaction in response.data ?? []) {
        listTotalTransactions.add(
            TotalTransactionsMapper.totalTransactionsToEntity(
                totalTransaction));
      }

      return listTotalTransactions;
      // final totalTransaction = TotalTransactionsMapper.totalTransactionsToEntity(response.data);
      // return totalTransaction;
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

  Future<String> createSuscription(String id) async {
    try {
      final response =
          await dio.post('/payment/create/suscription', data: {"userUuid": id});

      final orderPayment = response.data['sandbox_init_point'];
      return orderPayment;
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
