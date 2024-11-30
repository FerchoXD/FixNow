import 'package:fixnow/domain/entities/user_temp.dart';

class UserMapperTemp {
  static UserTemp fromJson(Map<String, dynamic> json) {
    return UserTemp(
      uuid: json['uuid'] as String,
      address: json['address'] as String,
      workExperience: json['workexperience'] as String,
      standardPrice: (json['standardprice'] as num).toDouble(),
      hourlyRate: (json['hourlyrate'] as num).toDouble(),
      selectedServices: List<String>.from(json['selectedservices'] ?? []),
      quotation: (json['quotation'] as num).toDouble(),
      relevance: (json['relevance'] as num).toDouble(),
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      fullName: json['fullname'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      token: json['token'] as String?,
      activationToken: json['activationToken'] as String,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static Map<String, dynamic> toJson(UserTemp user) {
    return {
      'uuid': user.uuid,
      'address': user.address,
      'workexperience': user.workExperience,
      'standardprice': user.standardPrice,
      'hourlyrate': user.hourlyRate,
      'selectedservices': user.selectedServices,
      'quotation': user.quotation,
      'relevance': user.relevance,
      'firstname': user.firstName,
      'lastname': user.lastName,
      'fullname': user.fullName,
      'phone': user.phone,
      'email': user.email,
      'password': user.password,
      'role': user.role,
      'token': user.token,
      'activationToken': user.activationToken,
      'verifiedAt': user.verifiedAt?.toIso8601String(),
      'updatedAt': user.updatedAt.toIso8601String(),
      'createdAt': user.createdAt.toIso8601String(),
    };
  }
}
