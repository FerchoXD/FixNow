import 'package:fixnow/domain/entities/user.dart';

class UserMapper {
  static User contactJsonToEntity(Map<String, dynamic> json) => User(
      id: json['uuid'] ?? '',
      name: json['firstname'] ?? '',
      lastName: json['lastname'] ?? '',
      fullname: json['fullname'] ?? '${json['firstname'] ?? ''} ${json['lastname'] ?? ''}',
      phoneNumber: json['phone'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      profileUrl: json['profileurl'] ?? 'PENDING',
      profilefileNames: json['profilefilenames'] ?? 'PENDING',
      address: json['address'] ?? 'PENDING',
      workexperience: json['workexperience'] ?? 'PENDING',
      standardprice: (json['standardprice'] ?? 0).toDouble(),
      quotation: (json['quotation'] ?? 0).toDouble(),
      hourlyrate: (json['hourlyrate'] ?? 0).toDouble(),
      selectedServices: json['selectedservices'] != null
          ? List<String>.from(json['selectedservices'])
          : [],
      relevance: (json['relevance'] ?? 0).toDouble(),
      token: json['token'],
      activateToken: json['activationToken'] ?? '',
      verifiedAt: json['verifiedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '');
}
