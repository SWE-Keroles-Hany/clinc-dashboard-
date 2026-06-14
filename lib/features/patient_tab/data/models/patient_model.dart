class PatientModel {
  final String patientId;
  final String fullName;
  final int age;
  final String gender;
  final String phoneNumber;
  final String lastVisitDate;
  final String profilePicUrl;

  PatientModel({
    required this.patientId,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.lastVisitDate,
    required this.profilePicUrl,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      patientId: json['patientId']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      age: json['age'] is int
          ? json['age']
          : int.tryParse(json['age']?.toString() ?? '') ?? 0,
      gender: json['gender']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      lastVisitDate: json['lastVisitDate']?.toString() ?? '',
      profilePicUrl: json['profilePicUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'lastVisitDate': lastVisitDate,
      'profilePicUrl': profilePicUrl,
    };
  }
}
