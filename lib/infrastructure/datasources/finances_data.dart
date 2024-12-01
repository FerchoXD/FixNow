import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/total_transactions.dart';
import 'package:fixnow/domain/mappers/total_transactions_mapper.dart';
import 'package:fixnow/infrastructure/errors.dart';

class FinancesData {
  final dio = Dio(BaseOptions(baseUrl: "http://192.168.1.82:3005/api/v1"));

  Future<TotalTransactions> getTotalTransactions(
      String userId, String year, String month) async {
    try {
      final response = await dio.post('/finances/transactions/user',
          data: {"userId": userId, "year": year, "month": month});

      final totalTransaction =
          TotalTransactionsMapper.totalTransactionsToEntity(response.data);
      return totalTransaction;
    } on DioException catch (e) {
      // if(e.type == DioExceptionType.connectionTimeout) throw CustomError(e.messag, errorCode) 
      throw Error();
    } catch (e) {
      throw Exception();
    }
  }
}

