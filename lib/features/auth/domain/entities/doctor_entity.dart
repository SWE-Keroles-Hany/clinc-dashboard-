class DoctorEntity {
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
  const DoctorEntity({
    required this.fullName,
    required this.email,
    required this.password,
    required this.gender,
    required this.phoneNumber,
    required this.specialty,
    required this.yearsOfExperience,
    required this.clinicAddress,
    required this.bio,
    required this.profilePictureUrl,
  });
}
