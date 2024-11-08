import 'package:fixnow/domain/entities/user.dart';

class UserMapper {
  static User contactJsonToEntity(Map<String, dynamic> json) => User(
      id: json['id'] ?? '',
      name: json['firstname'] ?? '',
      lastName: json['lastname'] ?? '',
      phoneNumber: json['phone'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      profileUrl: json['profileurl'] ?? 'PENDING',
      profilefileNames: json['profilefilenames'] ?? 'PENDING',
      address: json['address'] ?? 'PENDING',
      workexperience: json['workexperience'] ?? 'PENDING',
      standardrice: (json['standardprice'] ?? 0).toDouble(),
      hourlyrate: (json['hourlyrate'] ?? 0).toDouble(),
      selectedServices: json['selectedservices'] != null
          ? List<String>.from(json['selectedservices'])
          : [],
      token: json['token'],
      activateToken: json['activationToken'] ?? '',
      verifiedAt: json['verifiedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '');
}
