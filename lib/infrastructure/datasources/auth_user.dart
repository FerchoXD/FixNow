import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/mappers/contact_mapper.dart';

class AuthUser {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<User> register(String name, String lastName, String email,
      String phoneNumber, String password, String role) async {
    try {
      final response = await dio.post("/auth/", data: {
        "firstname": name,
        "lastname": lastName,
        "email": email,
        "phone": phoneNumber,
        "password": password,
        "role": role,
      });
      final user = UserMapper.contactJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw Error();
    }
  }

  Future<User> activateAccount(String code) async {
    try {
      final response = await dio.put('/$code/activate');
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
      final response = await dio.get('/get/data',
          options: Options(headers: {'Authorization': token}));
      final user = UserMapper.contactJsonToEntity(response.data);
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
