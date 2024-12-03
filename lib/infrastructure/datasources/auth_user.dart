import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/entities/user_temp.dart';
import 'package:fixnow/domain/mappers/contact_mapper.dart';
import 'package:fixnow/domain/mappers/user_temp_mapper.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';

class AuthUser {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<UserTemp> register(String name, String lastName, String email,
      String phoneNumber, String password, String role) async {
    try {
      final response = await dio.post("/auth", data: {
        "firstname": name,
        "lastname": lastName,
        "email": email,
        "phone": phoneNumber,
        "password": password,
        "role": role,
      });
      final userTemp = UserMapperTemp.fromJson(response.data);
      return userTemp;
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

  Future<User> activateAccount(String code) async {
    try {
      final response = await dio.put('/auth/$code/activate');
      final user = UserMapper.contactJsonToEntity(response.data['response']);
      print(user);
      return user;
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

  Future login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });
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

  Future<User> getUser(String token) async {
    try {
      final response = await dio.get('/auth/get/data',
          options: Options(headers: {'Authorization': token}));
      final user = UserMapper.contactJsonToEntity(response.data['data']);
      return user;
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

  Future logout(String? email) async {
    try {
      final response =
          await dio.post('/users/auth/logout', data: {"email": email});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
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
}
