import 'package:fixnow/domain/entities/calendar_supplier.dart';
import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/domain/mappers/calendar_mapper.dart';

class UserMapper {
  static User contactJsonToEntity(Map<String, dynamic> json) => User(
        id: json['uuid'] as String,
        name: json['firstname'] as String,
        lastName: json['lastname'] as String,
        fullname: json['fullname'] as String,
        phoneNumber: json['phone'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        role: json['role'] as String,
        address: json['address'] as String,
        workExperience: json['workexperience'] as String,
        standardPrice: (json['standardprice'] as num).toDouble(),
        quotation: (json['quotation'] as num).toDouble(),
        hourlyRate: (json['hourlyrate'] as num).toDouble(),
        selectedServices: List<String>.from(json['selectedservices']),
        relevance: (json['relevance'] as num).toDouble(),
        token: json['token'] as String?,
        activationToken: json['activationToken'] as String,
        verifiedAt: json['verifiedAt'] != null
            ? DateTime.parse(json['verifiedAt'])
            : null,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        profileImages: (json['images'] as List<dynamic>?)
                ?.map((image) => image['images'] as String)
                .toList() ??
            [],
        calendar: (json['calendar'] as List<dynamic>?)
                ?.map((c) => CalendarMapper.calendarJsonToEntity(c))
                .toList() ??
            [],
      );
}
