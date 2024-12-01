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
      workexperience: json['workexperience'],
      standardPrice: json['standardprice'] != null ? (json['standardprice'] as num).toDouble() : 0.0,
      hourlyRate: json['hourlyrate'] != null
          ? (json['hourlyrate'] as num).toDouble()
          : 0.0,
      selectedServices: List<String>.from(json['selectedservices']),
      quotation: (json['quotation'] as num).toDouble(),
      relevance: (json['relevance'] as num).toDouble(),
      token: json['token'],
      activationToken: json['activationToken'],
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images: (json['images'] as List)
          .map((imageItem) => imageItem['images'] as String)
          .toList(),
      calendar: (json['calendar'] as List)
          .map((item) => CalendarMapper.calendarJsonToEntity(item))
          .toList(),
    );
  }
}
