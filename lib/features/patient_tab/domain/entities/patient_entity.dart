class PatientEntity {
  final int patientId;
  final String fullName;
  final int age;
  final String gender;
  final String phoneNumber;
  final String lastVisitDate;
  final String profilePicUrl;

  const PatientEntity({
    required this.patientId,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.lastVisitDate,
    required this.profilePicUrl,
  });
}
