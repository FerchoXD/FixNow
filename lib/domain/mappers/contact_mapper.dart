import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/mappers/calendar_mapper.dart';

class UserMapper {
  static User contactJsonToEntity(Map<String, dynamic> json) {
    return User(
      id: json['uuid'] as String?,
      googleId: json['googleId'] as String?,
      name: json['firstname'] as String?,
      lastName: json['lastname'] as String?,
      fullname: json['fullname'] as String?,
      phoneNumber: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      address: json['address'] as String?,
      workExperience: json['workexperience'] as String?,
      standardPrice: (json['standardprice'] as num?)?.toDouble(),
      quotation: (json['quotation'] as num?)?.toDouble(),
      hourlyRate: (json['hourlyrate'] as num?)?.toDouble(),
      selectedServices: (json['selectedservices'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relevance: (json['relevance'] as num?)?.toDouble(),
      token: json['token'] as String?,
      activationToken: json['activationToken'] as String?,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.tryParse(json['verifiedAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      profileImages: (json['images'] as List<dynamic>?)
          ?.map((imageItem) => imageItem['images'] as String?)
          .whereType<String>()
          .toList(),
      calendar: (json['calendar'] as List<dynamic>?)
          ?.map((c) => CalendarMapper.calendarJsonToEntity(c))
          .toList(),
    );
  }
}
