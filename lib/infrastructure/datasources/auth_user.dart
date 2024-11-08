import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/mappers/contact_mapper.dart';

class AuthUser {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<User> register(String name, String lastName, String email,
      String phoneNumber, String password, String role) async {
    print({name, lastName, email, phoneNumber, password, role});
    try {
      final response = await dio.post("/users/", data: {
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
      print(e);
      throw Error();
    }
  }

  Future<void> activateAccount(String code) async {
    try {
      final response = await dio.put('/users/$code/activate');
      print(response.data.reponse);
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
