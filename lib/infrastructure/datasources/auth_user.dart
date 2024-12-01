import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/entities/user_temp.dart';
import 'package:fixnow/domain/mappers/contact_mapper.dart';
import 'package:fixnow/domain/mappers/user_temp_mapper.dart';

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
    } catch (e) {
      throw Error();
    }
  }

  Future<User> activateAccount(String code) async {
    try {
      final response = await dio.put('/auth/$code/activate');
      final user = UserMapper.contactJsonToEntity(response.data['response']);
      return user;
    } catch (e) {
      throw Error();
    }
  }

  Future login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });
      return response.data;
    } catch (e) {
      throw Error();
    }
  }

  Future<User> getUser(String token) async {
    try {
      final response = await dio.get('/auth/get/data',
          options: Options(headers: {'Authorization': token}));
      final user = UserMapper.contactJsonToEntity(response.data['data']);
      return user;
    } catch (e) {
      throw Error();
    }
  }

  Future logout(String email) async {
    try {
      final response =
          await dio.post('/users/auth/logout', data: {"email": email});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }
}
