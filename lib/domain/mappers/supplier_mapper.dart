import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/domain/mappers/calendar_mapper.dart';

class SupplierMapper {
  static Supplier supplierJsonToEntity(Map<String, dynamic> json) {
    return Supplier(
      uuid: json['uuid'],
      googleId: json['googleId'] as String?,
      firstname: json['firstname'],
      lastname: json['lastname'],
      fullname: json['fullname'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      address: json['address'],
      workExperience: json['workexperience'],
      standardPrice: json['standardprice'],
      hourlyRate: json['hourlyrate'],
      selectedServices: List<String>.from(json['selectedservices']),
      quotation: json['quotation'],
      relevance: json['relevance'],
      token: json['token'],
      activationToken: json['activationToken'],
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images: List<String>.from(json['images']),
      calendar: (json['calendar'] as List)
          .map((item) => CalendarMapper.calendarJsonToEntity(item))
          .toList(),
    );
  }
}
