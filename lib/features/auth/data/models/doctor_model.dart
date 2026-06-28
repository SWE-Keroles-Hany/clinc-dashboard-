class DoctorModel {
  int? id;
  final String fullName;
  final String email;
  final String password;
  final String gender;
  final String phoneNumber;
  final String specialty;
  final int? yearsOfExperience;
  final String? clinicAddress;
  final String? bio;
  final String? profilePictureUrl;

  DoctorModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.specialty,
    required this.yearsOfExperience,
    required this.clinicAddress,
    required this.bio,
    required this.profilePictureUrl,
    required this.password,
    required this.gender,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? json['Id'] ?? 0,
      fullName:
          json['fullName']?.toString() ?? json['FullName']?.toString() ?? '',
      email: json['email']?.toString() ?? json['Email']?.toString() ?? '',
      phoneNumber:
          json['phoneNumber']?.toString() ??
          json['PhoneNumber']?.toString() ??
          '',
      specialty:
          json['specialty']?.toString() ?? json['Specialty']?.toString() ?? '',
      yearsOfExperience: _toInt(
        json['yearsOfExperience'] ?? json['YearsOfExperience'],
      ),
      clinicAddress:
          json['clinicAddress']?.toString() ??
          json['ClinicAddress']?.toString(),
      bio: json['bio']?.toString() ?? json['Bio']?.toString(),
      profilePictureUrl: _firstNotBlankString([
        json['profilePictureUrl'],
        json['profilePicture'],
        json['ProfilePicture'],
      ]),
      password:
          json['password']?.toString() ?? json['Password']?.toString() ?? '',
      gender: json['gender']?.toString() ?? json['Gender']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FullName': fullName,
      'Email': email,
      'Password': password,
      'PhoneNumber': phoneNumber,
      'Specialty': specialty,
      'YearsOfExperience': yearsOfExperience,
      'ClinicAddress': clinicAddress,
      'Bio': bio,
      'ProfilePicture': profilePictureUrl,
    };
  }

  Map<String, dynamic> toUpdateProfileJson() {
    return {
      'fullName': fullName,
      'specialty': specialty,
      'yearsOfExperience': yearsOfExperience ?? 0,
      'clinicAddress': clinicAddress ?? '',
      'bio': bio ?? '',
      'phoneNumber': phoneNumber,
    };
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static String? _firstNotBlankString(List<dynamic> values) {
    for (final value in values) {
      final text = value?.toString().trim();
      if (text != null && text.isNotEmpty && text.toLowerCase() != 'null') {
        return text;
      }
    }
    return null;
  }
}
