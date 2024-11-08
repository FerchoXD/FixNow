class User {
  final String id;
  final String name;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String role;
  final String profileUrl;
  final String profilefileNames;
  final String address;
  final String workexperience;
  final double standardrice;
  final double hourlyrate;
  final List<String> selectedServices;
  final String? token;
  final String activateToken;
  final String? verifiedAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.role,
    required this.profileUrl,
    required this.profilefileNames,
    required this.address,
    required this.workexperience,
    required this.standardrice,
    required this.hourlyrate,
    required this.selectedServices,
    this.token,
    required this.activateToken,
    this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isSuplier {
    return role.contains('suplier');
  }

  bool get isClient {
    return role.contains('client');
  }
}
