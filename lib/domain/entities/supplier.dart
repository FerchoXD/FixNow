import 'package:fixnow/domain/entities/calendar_supplier.dart';

class Supplier {
  final String uuid;
  final String? googleId;
  final String firstname;
  final String lastname;
  final String fullname;
  final String phone;
  final String email;
  final String password;
  final String role;
  final String address;
  final String workexperience;
  final double standardPrice;
  final double hourlyRate;
  final List<String> selectedServices;
  final double quotation;
  final double relevance;
  final String? token;
  final String activationToken;
  final DateTime? verifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? images;
  final List<CalendarSupplier>? calendar;

  Supplier({
    required this.uuid,
    this.googleId,
    required this.firstname,
    required this.lastname,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    required this.address,
    required this.workexperience,
    required this.standardPrice,
    required this.hourlyRate,
    required this.selectedServices,
    required this.quotation,
    required this.relevance,
    this.token,
    required this.activationToken,
    this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.images,
    this.calendar,
  });
}
