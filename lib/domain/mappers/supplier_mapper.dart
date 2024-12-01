import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/domain/mappers/calendar_mapper.dart';

class SupplierMapper {
  static Supplier supplierJsonToEntity(Map<String, dynamic> json) {
    return Supplier(
      uuid: json['uuid'] as String,
      googleId: json['googleId'] as String?,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      fullname: json['fullname'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      address: json['address'] as String,
      workexperience: json['workexperience'] as String,
      standardPrice: json['standardprice'] != null
          ? (json['standardprice'] as num).toDouble()
          : 0.0,
      hourlyRate: json['hourlyrate'] != null
          ? (json['hourlyrate'] as num).toDouble()
          : 0.0,
      selectedServices: List<String>.from(json['selectedservices'] ?? []),
      quotation: (json['quotation'] as num).toDouble(),
      relevance: (json['relevance'] as num).toDouble(),
      token: json['token'] as String?,
      activationToken: json['activationToken'] as String,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
       images: (json['images'] as List<dynamic>?)
          ?.map((imageItem) => imageItem['images'] as String?)
          .whereType<String>()
          .toList(),
      calendar: (json['calendar'] as List<dynamic>?)
          ?.map((c) => CalendarMapper.calendarJsonToEntity(c))
          .toList(),
    );
  }
}

