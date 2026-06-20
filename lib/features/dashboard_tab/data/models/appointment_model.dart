class AppointmentModel {
  final int appointmentId;
  final String patientName;
  final String appointmentDate;
  final String status;

  AppointmentModel({
    required this.appointmentId,
    required this.patientName,
    required this.appointmentDate,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointmentId'] ?? json['appoinmentId'] ?? 0,
      patientName: json['patientName']?.toString() ?? '',
      appointmentDate:
          json['appointmentDate']?.toString() ??
          json['appintmentDate']?.toString() ??
          '',
      status: json['status']?.toString() ?? '',
    );
  }
}
