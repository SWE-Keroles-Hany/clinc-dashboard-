class DoctorModel {
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

  Map<String, dynamic> toJson() {
    return {
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
}
