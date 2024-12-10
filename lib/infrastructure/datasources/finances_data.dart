import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/total_transactions.dart';
import 'package:fixnow/domain/mappers/total_transactions_mapper.dart';
import 'package:fixnow/infrastructure/errors.dart';

class FinancesData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<TotalTransactions> getTotalTransactions(
      String userId, String year, String month) async {
    try {
      final response = await dio.post('/finance/transactions/user',
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
        '/finance/transactions/total/user/$userId',
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

  Future getTransactionsByUserId(String userId) async {
    try {
      final response = await dio.get('/finance/transactions/user/$userId');

      final List<Map<String, dynamic>> transactions = [];
      for (final transaction in response.data ?? []) {
        transactions.add(transaction);
      }

      return transactions;
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

  Future createTransaction(String typeTransaction, double amount, String date,
      String category, String userId, String description) async {
    try {
      final response = await dio.post('/finance/transactions', data: {
        "type": typeTransaction,
        "amount": amount,
        "date": date,
        "category": category,
        "userId": userId,
        "description": description,
        "state": "completed"
      });

      final transaction = response.data;
      return transaction;
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
