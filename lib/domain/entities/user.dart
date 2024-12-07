import 'package:fixnow/domain/entities/calendar_supplier.dart';

class User {
  final String? id;
  final String? googleId;
  final String? name;
  final String? lastName;
  final String? fullname;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final String? role;
  final String? address;
  final String? workExperience;
  final double? standardPrice;
  final double? quotation;
  final double? hourlyRate;
  final List<String>? selectedServices;
  final double? relevance;
  final String? token;
  final String? activationToken;
  final DateTime? verifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String>? profileImages;
  final List<CalendarSupplier>? calendar;

  User({
    this.id,
    this.googleId,
    this.name,
    this.lastName,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.password,
    this.role,
    this.address,
    this.workExperience,
    this.standardPrice,
    this.quotation,
    this.hourlyRate,
    this.selectedServices,
    this.relevance,
    this.token,
    this.activationToken,
    this.verifiedAt,
    this.createdAt,
    this.updatedAt,
    this.profileImages,
    this.calendar,
  });
  @override
  String toString() {
    return '''
User(
  profileImages: $profileImages,
)
''';
  }
}
