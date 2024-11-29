class User {
  final String id;
  final String name;
  final String lastName;
  final String fullname;
  final String phoneNumber;
  final String email;
  final String password;
  final String role;
  final String profileUrl;
  final String profilefileNames;
  final String address;
  final String workexperience;
  final double standardprice;
  final double quotation;
  final double hourlyrate;
  final List<String> selectedServices;
  final double relevance;
  final String? token;
  final String activateToken;
  final String? verifiedAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.fullname,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.role,
    required this.profileUrl,
    required this.profilefileNames,
    required this.address,
    required this.workexperience,
    required this.standardprice,
    required this.quotation,
    required this.hourlyrate,
    required this.selectedServices,
    required this.relevance,
    this.token,
    required this.activateToken,
    this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return '''
User {
  id: $id,
  name: $name,
  lastName: $lastName,
  fullname: $fullname,
  phoneNumber: $phoneNumber,
  email: $email,
  role: $role,
  profileUrl: $profileUrl,
  address: $address,
  workexperience: $workexperience,
  standardprice: $standardprice,
  quotation: $quotation,
  hourlyrate: $hourlyrate,
  selectedServices: $selectedServices,
  relevance: $relevance,
  token: $token,
  activateToken: $activateToken,
  verifiedAt: $verifiedAt,
  createdAt: $createdAt,
  updatedAt: $updatedAt
}
''';
  }
}
