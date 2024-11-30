import 'package:fixnow/domain/entities/calendar_supplier.dart';

class User {
  final String id;
  final String name;
  final String lastName;
  final String fullname;
  final String phoneNumber;
  final String email;
  final String password;
  final String role;
  final String address;
  final String workExperience;
  final double standardPrice;
  final double quotation;
  final double hourlyRate;
  final List<String> selectedServices;
  final double relevance;
  final String? token;
  final String activationToken;
  final DateTime? verifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> profileImages;
  final List<CalendarSupplier> calendar;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.fullname,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.role,
    required this.address,
    required this.workExperience,
    required this.standardPrice,
    required this.quotation,
    required this.hourlyRate,
    required this.selectedServices,
    required this.relevance,
    this.token,
    required this.activationToken,
    this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImages,
    required this.calendar,
  });
}
