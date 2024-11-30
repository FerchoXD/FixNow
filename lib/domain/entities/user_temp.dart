class UserTemp {
  final String uuid;
  final String address;
  final String workExperience;
  final double standardPrice;
  final double hourlyRate;
  final List<String> selectedServices;
  final double quotation;
  final double relevance;
  final String firstName;
  final String lastName;
  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String role;
  final String? token;
  final String activationToken;
  final DateTime? verifiedAt;
  final DateTime updatedAt;
  final DateTime createdAt;

  UserTemp({
    required this.uuid,
    required this.address,
    required this.workExperience,
    required this.standardPrice,
    required this.hourlyRate,
    required this.selectedServices,
    required this.quotation,
    required this.relevance,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    this.token,
    required this.activationToken,
    this.verifiedAt,
    required this.updatedAt,
    required this.createdAt,
  });
}
